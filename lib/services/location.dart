import 'package:attendance/services/assets.dart';
import 'package:attendance/ui/pages/home/widgets/location.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  static Future<bool> checkService() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    return isServiceEnabled;
  }

  static Future<bool> checkPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      } else if (permission == LocationPermission.deniedForever) {
        await showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => LocationModal(
            asset: illustrationLocation,
            description: 'Izinkan kami untuk mengakses lokasi Anda',
            onTap: () => Geolocator.openAppSettings(),
          ),
        );
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  static Future<String?> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      return placemark[2].street;
    } catch (e) {
      throw e;
    }
  }
}
