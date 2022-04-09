import 'package:attendance/services/assets.dart';
import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttendSuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            illustrationSuccess,
            width: 250,
          ),
          SizedBox(height: 24),
          Text(
            'Absen Anda berhasil dikirim',
            style: poppinsBlackw400,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 16),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('OK'),
            ),
          ),
        ],
      ),
    );
  }
}
