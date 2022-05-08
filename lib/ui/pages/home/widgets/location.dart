import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationModal extends StatelessWidget {
  final String? asset, description;
  final VoidCallback? onTap;

  LocationModal({this.asset, this.description, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            asset ?? '',
            width: 200,
          ),
          SizedBox(height: 24),
          Text(
            description ?? '',
            textAlign: TextAlign.center,
            style: poppinsBlackw400,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 24),
            child: ElevatedButton(
              onPressed: onTap,
              child: Text('Aktifkan'),
            ),
          ),
        ],
      ),
    );
  }
}
