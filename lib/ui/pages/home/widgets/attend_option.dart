import 'package:attendance/providers/attendance_provider.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendOptionModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Consumer<AttendanceProvider>(
        builder: (context, value, _) {
          final isAttend = value.isAttend;
          final date = value.attendance?.dateIn;
          final currentDate = DateTime.now();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    "Pilih Absen",
                    style: poppinsBlackw400.copyWith(fontSize: 16),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 16),
              Divider(height: 0),
              ListTile(
                onTap: () {
                  if (!isAttend) {
                    if (date != null &&
                        currentDate.difference(date).inDays == 0) {
                      Navigator.pop(context);
                      showSnackBar(
                          context, 'Anda dapat melakukan absen lagi besok');
                    } else {
                      Navigator.pop(context, 'in');
                    }
                  } else {
                    Navigator.pop(context);
                    showSnackBar(context, 'Anda sudah melakukan absen masuk');
                  }
                },
                minLeadingWidth: 12,
                leading: Icon(Icons.inventory_rounded),
                title: Text(
                  'Absen Masuk',
                  style: poppinsBlackw400,
                ),
              ),
              Divider(height: 0),
              ListTile(
                onTap: () {
                  if (isAttend) {
                    Navigator.pop(context, 'out');
                  } else {
                    Navigator.pop(context);
                    if (date != null &&
                        currentDate.difference(date).inDays == 0) {
                      showSnackBar(
                          context, 'Anda dapat melakukan absen lagi besok');
                    } else {
                      showSnackBar(context, 'Anda belum melakukan absen masuk');
                    }
                  }
                },
                minLeadingWidth: 12,
                leading: Icon(Icons.inventory_rounded),
                title: Text(
                  'Absen Pulang',
                  style: poppinsBlackw400,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
