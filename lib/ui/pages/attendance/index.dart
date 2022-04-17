import 'package:attendance/models/absent.dart';
import 'package:attendance/models/attendance.dart';
import 'package:attendance/models/user.dart';
import 'package:attendance/providers/attendance_provider.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/services/utils.dart';
import 'package:attendance/ui/widgets/container_shadow.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/empty.dart';
import 'package:attendance/ui/widgets/refresh_view.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendancePage extends StatefulWidget {
  final User? argument;

  AttendancePage({this.argument});

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool _loading = false, _loadingMore = false;
  DateTime _currentDate = DateTime.now();
  final _cScroll = ScrollController();
  List<Attendance> _attendances = [];
  String? _period, _attendance;
  List<Absent> _absent = [];

  int _limit = 10;

  @override
  void initState() {
    super.initState();
    _cScroll.addListener(_scrollListener);
    _getData();
  }

  @override
  void dispose() {
    _cScroll.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_cScroll.offset >= _cScroll.position.maxScrollExtent &&
        !_cScroll.position.outOfRange) _getData(true);
  }

  Future<void> _getData([bool refresh = false]) async {
    if (refresh)
      _limit += 10;
    else
      _limit = 10;

    await Future.wait([
      _getAttendances(refresh),
    ]);
  }

  Future<void> _getAttendances([bool refresh = false]) async {
    final prov = Provider.of<AttendanceProvider>(context, listen: false);
    setState(() {
      if (refresh)
        _loadingMore = true;
      else
        _loading = true;
    });
    try {
      await Future.delayed(Duration(milliseconds: 500)).then((_) async {
        await prov.getAttendances(limit: _limit, id: widget.argument?.id);
      });
      if (!mounted) return;
      _filter(attendances: prov.attendances ?? []);
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
    setState(() {
      if (refresh)
        _loadingMore = false;
      else
        _loading = false;
    });
  }

  void _filter({List<Attendance>? attendances, List<Absent>? absent}) {
    if (attendances != null) {
      _attendances = attendances
          .where((e) => e.dateIn!.formatMMMMy() == _currentDate.formatMMMMy())
          .toList();
    } else if (absent != null) {
      _absent = absent
          .where((e) => e.date!.formatMMMMy() == _currentDate.formatMMMMy())
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Absensi',
      ),
      body: RefreshView(
        onRefresh: _getData,
        onLoadMore: _loadingMore,
        child: ListView(
          controller: _cScroll,
          padding: EdgeInsets.all(24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (widget.argument?.name ?? '-').capitalize(),
                      style: poppinsBlackw600.copyWith(fontSize: 16),
                    ),
                    Text(
                      widget.argument?.id ?? '-',
                      style: poppinsBlackw600.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                Consumer<UserProvider>(
                  builder: (context, value, _) => InkWell(
                    onTap: () {
                      if (value.user?.level == Level.Admin)
                        Navigator.pushNamed(context, profileRoute);
                      else
                        Navigator.pushNamed(context, settingRoute);
                    },
                    child: Icon(
                      value.user?.level == Level.Admin
                          ? Icons.edit_note_rounded
                          : Icons.settings,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                _periodOption(),
                SizedBox(width: 16),
                _attendanceOption(),
              ],
            ),
            SizedBox(height: 24),
            Visibility(
              visible: !_loading,
              replacement: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: CircularProgressIndicator(),
                ),
              ),
              child: Visibility(
                visible: _attendance == 'Tidak Hadir',
                replacement: _attendanceList(),
                child: _absentList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _periodOption() {
    List<String> periods = [];
    List<DateTime> dateTimes = [];
    DateTime current = DateTime.now();
    for (var i = 0; i < 12; i++) {
      var date = DateTime(current.year, current.month - i, current.day);
      periods.add(date.formatMMMMy());
      dateTimes.add(date);
    }

    return Expanded(
      child: ContainerShadow(
        color: blue,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 2, right: 6),
              child: Icon(
                Icons.calendar_month,
                color: white,
                size: 18,
              ),
            ),
            Expanded(
              child: DropdownButton<String>(
                isExpanded: true,
                underline: SizedBox(),
                icon: Icon(Icons.expand_more, color: white),
                value: _period ?? _currentDate.formatMMMMy(),
                style: poppinsWhitew500,
                onChanged: (value) {
                  var i = periods.indexOf(value!);
                  _currentDate = dateTimes[i];
                  _period = value;
                  if (_attendance != 'Tidak Hadir') _getAttendances();
                },
                dropdownColor: blue,
                items: periods.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _attendanceOption() {
    List<String> attendance = ['Hadir', 'Tidak Hadir'];

    return Expanded(
      child: ContainerShadow(
        color: blue,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 2, right: 6),
              child: Icon(
                Icons.person,
                color: white,
                size: 18,
              ),
            ),
            Expanded(
              child: DropdownButton<String>(
                isExpanded: true,
                underline: SizedBox(),
                icon: Icon(Icons.expand_more, color: white),
                value: _attendance ?? attendance[0],
                style: poppinsWhitew500,
                onChanged: (value) {
                  setState(() => _attendance = value);
                  if (value == 'Hadir') _getAttendances();
                },
                dropdownColor: blue,
                items: attendance.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _attendanceList() {
    return Visibility(
      visible: _attendances.isNotEmpty,
      replacement: Padding(
        padding: EdgeInsets.only(top: 55),
        child: EmptyWidget(action: _getData),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _attendances.length,
        padding: EdgeInsets.only(bottom: 60),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final data = _attendances[index];

          return ContainerShadow(
            onTap: () => Navigator.pushNamed(context, profileRoute),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data.dateIn != null)
                        Text(
                          data.dateIn!.formatMMMMddy(),
                          style: poppinsBlackw600.copyWith(fontSize: 18),
                        ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          if (data.dateIn != null)
                            Text(
                              data.dateIn!.formathhmm(),
                              style: poppinsBlackw600.copyWith(fontSize: 11),
                            ),
                          Text(
                            '   s.d   ',
                            style: poppinsBlackw600.copyWith(fontSize: 11),
                          ),
                          if (data.dateOut != null)
                            Text(
                              data.dateOut!.formathhmm(),
                              style: poppinsBlackw600.copyWith(fontSize: 11),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Icon(
                  Icons.chevron_right,
                  color: Colors.black.withOpacity(0.7),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8);
        },
      ),
    );
  }

  Widget _absentList() {
    return Visibility(
      visible: _absent.isNotEmpty,
      replacement: Padding(
        padding: EdgeInsets.only(top: 55),
        child: EmptyWidget(action: _getData),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _absent.length,
        padding: EdgeInsets.only(bottom: 60),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final data = _absent[index];

          return ContainerShadow(
            onTap: () => Navigator.pushNamed(context, profileRoute),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data.date != null)
                        Text(
                          data.date!.formatMMMMy(),
                          style: poppinsBlackw600.copyWith(fontSize: 18),
                        ),
                      SizedBox(height: 4),
                      if (data.date != null)
                        Text(
                          data.date!.formathhmm(),
                          style: poppinsBlackw600.copyWith(fontSize: 11),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Icon(
                  Icons.chevron_right,
                  color: Colors.black.withOpacity(0.7),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8);
        },
      ),
    );
  }
}
