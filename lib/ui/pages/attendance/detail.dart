import 'package:attendance/models/attendance.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/services/utils.dart';
import 'package:attendance/ui/pages/attendance/widgets/border_network_image.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailAttendancePage extends StatelessWidget {
  final Attendance? argument;

  DetailAttendancePage({this.argument});

  @override
  Widget build(BuildContext context) {
    final dateIn =
        argument?.dateIn != null ? argument?.dateIn?.formatMMMMddyhhmm() : '';
    final dateOut =
        argument?.dateOut != null ? argument?.dateOut?.formatMMMMddyhhmm() : '';

    return Scaffold(
      appBar: CustomAppBar(title: 'Absensi'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            argument?.name ?? '-',
            style: poppinsBlackw600.copyWith(fontSize: 16),
          ),
          Consumer<UserProvider>(
            builder: (context, value, _) => Text(
              value.nign ?? '-',
              style: poppinsBlackw600.copyWith(fontSize: 12),
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  'Absen Masuk',
                  style: poppinsBlackw600.copyWith(fontSize: 14),
                ),
              ),
              Text(
                ':\t\t',
                style: poppinsBlackw600.copyWith(fontSize: 14),
              ),
              Text(
                dateIn!,
                style: poppinsBlackw400.copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  'Alamat',
                  style: poppinsBlackw600.copyWith(fontSize: 14),
                ),
              ),
              Text(
                ':',
                style: poppinsBlackw600.copyWith(fontSize: 14),
              ),
            ],
          ),
          Text(
            argument?.locationIn ?? '',
            style: poppinsBlackw400.copyWith(fontSize: 14),
          ),
          BorderNetworkImage(url: argument?.imageUrlIn),
          SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  'Absen Pulang',
                  style: poppinsBlackw600.copyWith(fontSize: 14),
                ),
              ),
              Text(
                ':\t\t',
                style: poppinsBlackw600.copyWith(fontSize: 14),
              ),
              Text(
                dateOut!,
                style: poppinsBlackw400.copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  'Alamat',
                  style: poppinsBlackw600.copyWith(fontSize: 14),
                ),
              ),
              Text(
                ':',
                style: poppinsBlackw600.copyWith(fontSize: 14),
              ),
            ],
          ),
          Text(
            argument?.locationOut ?? '',
            style: poppinsBlackw400.copyWith(fontSize: 14),
          ),
          BorderNetworkImage(url: argument?.imageUrlOut),
        ],
      ),
    );
  }
}
