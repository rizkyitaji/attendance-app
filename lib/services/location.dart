import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  static Future<bool> checkActivatedLocation() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      print("GPS sudah Aktif");
      return true;
    } else {
      print("GPS belum aktif");
      return false;
    }
  }

  static Future<bool> checkForPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    print("permission start");
    if (permission == LocationPermission.denied) {
      print("permission denied 1");
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      if (permission == LocationPermission.denied) {
        print("permission denied 2");
        return false;
      }
    }
    return true;
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
