import 'package:attendance/models/attendance.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/firebase.dart';
import 'package:attendance/services/location.dart';
import 'package:attendance/services/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AttendanceProvider extends ChangeNotifier {
  bool _isAttend = false;
  bool get isAttend => _isAttend;
  set isAttend(bool value) {
    _isAttend = value;
    notifyListeners();
  }

  List<Attendance>? _attendances;
  List<Attendance>? get attendances => _attendances;

  Attendance? _attendance;
  Attendance? get attendance => _attendance;

  void resetState() {
    _isAttend = false;
    _attendance = null;
    _attendances = null;
    notifyListeners();
  }

  Future<void> getAttendances({int? limit, String? id}) async {
    try {
      final response = await FirebaseService.get<List<DocumentSnapshot>>(
        collection: Collection.Attendance,
        limit: limit!,
        filter: 'user_id',
        query: id,
      );
      final snapshots = response.value ?? [];
      if (snapshots.isNotEmpty) {
        _attendances =
            snapshots.map((e) => Attendance.fromSnapshot(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> getDailyAttendance(String id) async {
    try {
      final response = await FirebaseService.get<DocumentSnapshot>(
          collection: Collection.Attendance, id: id);
      if (response.value!.exists) {
        _attendance = Attendance.fromSnapshot(response.value!);
        if (response.value?.get('date_in') == null) {
          _isAttend = false;
        } else {
          if (response.value?.get('date_out') == null) {
            _isAttend = true;
          } else {
            _isAttend = false;
          }
        }
      } else {
        _attendance = null;
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> attend(
    BuildContext context,
    XFile file,
    String type,
  ) async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    try {
      final currentDate = DateTime.now();
      final userId = prov.user?.id ?? '';
      final id = '${userId}_${currentDate.formatddMMy()}';
      final imageUrl = await FirebaseService.uploadImage(file, '${id}_$type');
      final location = await LocationServices.getCurrentLocation();
      final response = await FirebaseService.set<Attendance>(
        id: id,
        collection: Collection.Attendance,
        data: Attendance(
          id: id,
          name: prov.user?.name,
          userId: userId,
          imageUrlIn: type == 'in' ? imageUrl : _attendance?.imageUrlIn,
          imageUrlOut: type == 'out' ? imageUrl : null,
          locationIn: type == 'in' ? location : _attendance?.locationIn,
          locationOut: type == 'out' ? location : null,
          dateIn: type == 'in' ? currentDate : _attendance?.dateIn,
          dateOut: type == 'out' ? currentDate : null,
        ),
      );
      _attendance = response;
      _isAttend = !_isAttend;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
