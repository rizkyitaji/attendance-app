import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationOption extends StatelessWidget {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              Text(
                "Aktifkan Lokasi / GPS",
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
              Geolocator.openLocationSettings();
            },
            minLeadingWidth: 12,
            leading: Icon(Icons.gps_fixed),
            title: Text(
              'Pergi ke pengaturan lokasi',
              style: poppinsBlackw400,
            ),
          ),
        ],
      ),
    );
  }
}
