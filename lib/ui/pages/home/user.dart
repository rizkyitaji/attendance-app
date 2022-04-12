import 'package:attendance/models/attendance.dart';
import 'package:attendance/providers/attendance_provider.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/services/utils.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/loading_dialog.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
    final prov = Provider.of<AttendanceProvider>(context, listen: false);
    final prov2 = Provider.of<UserProvider>(context, listen: false);
    final id = '${prov2.user?.name}_${_currentDate.formatddMMy()}';
    try {
      await prov.getDailyAttendance(id);
      if (!mounted) return;
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  void _showModal() async {
    await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AttendOptionModal(),
    ).then((value) {
      if (value != null) _attend(value);
    });
  }

  void _attend(String type) async {
    final prov = Provider.of<AttendanceProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (!mounted) return;
      if (image != null) {
        showLoadingDialog(context);
        await prov.attend<Attendance>(context, image, type).then((_) {
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
      appBar: CustomAppBar(title: "ABSENSI GURU", showLogout: true),
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
                          user?.id ?? '-',
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
                SizedBox(height: 80),
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: isAttend ? blue : grey,
                  size: 150,
                ),
                SizedBox(height: 80),
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
                          Navigator.pushNamed(context, absentRoute);
                        },
                        child: Text("IZIN"),
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _showModal,
                        child: Text("ABSEN"),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, attendanceRoute,
                      arguments: user),
                  child: Text("DAFTAR ABSEN"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
