import 'package:attendance/models/user.dart';
import 'package:attendance/providers/attendance_provider.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/services/utils.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
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
  final _cScroll = ScrollController();
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
    final prov = Provider.of<AttendanceProvider>(context, listen: false);
    setState(() {
      if (refresh) {
        _loadingMore = true;
        _limit += 10;
      } else {
        _loading = true;
        _limit = 10;
      }
    });
    try {
      await Future.delayed(Duration(milliseconds: 500)).then((_) async {
        await prov.getAttendances(_limit);
      });
      if (!mounted) return;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Absensi',
      ),
      body: RefreshView(
        onRefresh: _getData,
        onLoadMore: _loadingMore,
        child: Consumer2<UserProvider, AttendanceProvider>(
          builder: (context, userProv, attendProv, _) {
            final user = userProv.user;
            // final attendances = attendProv.attendances ?? [];

            return ListView(
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
                    InkWell(
                      onTap: () {
                        if (user?.level == Level.Admin)
                          Navigator.pushNamed(context, profileRoute);
                        else
                          Navigator.pushNamed(context, settingRoute);
                      },
                      child: Icon(
                        user?.level == Level.Admin
                            ? Icons.edit_note_rounded
                            : Icons.settings,
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
