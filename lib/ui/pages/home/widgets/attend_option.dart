import 'package:attendance/providers/attendance_provider.dart';
import 'package:attendance/services/themes.dart';
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
                onTap: () => !isAttend ? Navigator.pop(context, 'in') : {},
                minLeadingWidth: 12,
                leading: Icon(Icons.inventory_rounded),
                title: Text(
                  'Absen Masuk',
                  style: poppinsBlackw400,
                ),
              ),
              Divider(height: 0),
              ListTile(
                onTap: () => isAttend ? Navigator.pop(context, 'out') : {},
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
