import 'package:attendance/models/absent.dart';
import 'package:attendance/providers/absent_provider.dart';
import 'package:attendance/providers/attendance_provider.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/location.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/services/utils.dart';
import 'package:attendance/ui/pages/home/widgets/location_service.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/loading_dialog.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/attend_option.dart';
import 'widgets/attend_success.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    final id = '${prov.user?.id}_${_currentDate.formatddMMy()}';
    await LocationServices.checkPermission();

    await Future.delayed(Duration(milliseconds: 500)).then((_) {
      _getUser();
      _getDailyAttendance(id);
      _getAbsent(id);
    });
  }

  Future<void> _getUser() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    final pref = await SharedPreferences.getInstance();
    final id = pref.getString('id') ?? '';
    try {
      await prov.getUser(id);
      if (!mounted) return;
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  Future<void> _getDailyAttendance(String id) async {
    final prov = Provider.of<AttendanceProvider>(context, listen: false);
    try {
      await prov.getDailyAttendance(id);
      if (!mounted) return;
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  Future<void> _getAbsent(String id) async {
    final prov = Provider.of<AbsentProvider>(context, listen: false);
    try {
      await prov.getAbsent(id);
      if (!mounted) return;
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  void _showModal() async {
    try {
      final isServiceEnabled = await LocationServices.checkService();
      final isPermissionGranted = await LocationServices.checkPermission();
      if (!mounted) return;
      if (isPermissionGranted) {
        if (isServiceEnabled) {
          await showModalBottomSheet<String>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => AttendOptionModal(),
          ).then((value) {
            if (value != null) _attend(value);
          });
        } else {
          await showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => LocationServiceModal(),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  void _attend(String type) async {
    final prov = Provider.of<AttendanceProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (!mounted) return;
      if (image != null) {
        showLoadingDialog(context);
        await prov.attend(context, image, type).then((_) {
          Navigator.pop(context);
          _showDialog();
        });
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  void _showDialog() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AttendSuccessDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Beranda",
        showLogout: true,
      ),
      body: RefreshIndicator(
        onRefresh: _getData,
        child: Consumer2<UserProvider, AttendanceProvider>(
          builder: (context, userProv, attendProv, _) {
            final user = userProv.user;
            final isAttend = attendProv.isAttend;

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
                          (user?.name ?? '-').capitalize(),
                          style: poppinsBlackw600.copyWith(fontSize: 16),
                        ),
                        Text(
                          user?.nign ?? '-',
                          style: poppinsBlackw600.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, settingRoute),
                      child: Icon(Icons.settings),
                    )
                  ],
                ),
                SizedBox(
                  height: height(context) - 380,
                  child: Icon(
                    Icons.check_circle_outline_rounded,
                    color: isAttend ? blue : grey,
                    size: 150,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _currentDate.formatMMMMddy(),
                  style: poppinsBlackw400.copyWith(fontSize: 15),
                ),
                Text(
                  _currentDate.formathhmm(),
                  style: poppinsBlackw400.copyWith(fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final prov =
                          Provider.of<AbsentProvider>(context, listen: false);
                      Navigator.pushNamed(
                        context,
                        absentRoute,
                        arguments: prov.absent ?? Absent(),
                      ).then((_) => _getData());
                    },
                    child: Text("IZIN"),
                  ),
                ),
                SizedBox(width: 32),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showModal();
                    },
                    child: Text("ABSEN"),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            OutlinedButton(
              onPressed: () {
                final prov = Provider.of<UserProvider>(context, listen: false);
                Navigator.pushNamed(
                  context,
                  attendanceRoute,
                  arguments: prov.user,
                ).then((_) => _getData());
              },
              child: Center(
                child: Text("DAFTAR ABSEN"),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
