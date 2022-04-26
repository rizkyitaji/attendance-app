import 'package:attendance/models/attendance.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/services/utils.dart';
import 'package:attendance/ui/pages/attendance/widgets/border_network_image.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class DetailAttendancePage extends StatelessWidget {
  final Attendance? argument;

  DetailAttendancePage({this.argument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Absensi'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            argument?.name ?? '-',
            style: poppinsBlackw600.copyWith(fontSize: 16),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Text(
                'Absen Masuk :',
                style: poppinsBlackw600.copyWith(fontSize: 14),
              ),
              Spacer(),
              Visibility(
                visible: argument?.dateIn != null,
                child: Text(
                  argument!.dateIn!.formatMMMMddyhhmm(),
                  style: poppinsBlackw600.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          Text(
            argument?.locationIn ?? '-',
            style: poppinsBlackw600.copyWith(fontSize: 14),
          ),
          BorderNetworkImage(argument?.imageUrlIn ?? '-'),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Absen Pulang :',
                style: poppinsBlackw600.copyWith(fontSize: 14),
              ),
              Spacer(),
              Visibility(
                visible: argument?.dateOut != null,
                child: Text(
                  argument!.dateOut!.formatMMMMddyhhmm(),
                  style: poppinsBlackw600.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          Text(
            argument?.locationIn ?? '-',
            style: poppinsBlackw600.copyWith(fontSize: 14),
          ),
          BorderNetworkImage(argument?.imageUrlOut ?? '-'),
        ],
      ),
    );
  }
}
