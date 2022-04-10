import 'package:attendance/models/attendance.dart';
import 'package:attendance/models/response.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/firebase.dart';
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
    _attendances = null;
    notifyListeners();
  }

  Future<void> getAttendances(int limit) async {
    try {
      final response = await FirebaseService.get<List<DocumentSnapshot>>(
          collection: Collection.Attendance, limit: limit);
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
        if (response.value?.get('date_out') != null) {
          _isAttend = false;
        }
        _isAttend = true;
      }
      _attendance = null;
      _isAttend = false;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<Response<T>> attend<T>(
    BuildContext context,
    XFile file,
    String type,
  ) async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    try {
      final currentDate = DateTime.now();
      final userName = prov.user?.name ?? '';
      final id = '${userName}_${currentDate.formatddMMy()}';
      final imageUrl = await FirebaseService.uploadImage(file, '${id}_$type');
      final response = await FirebaseService.set<T>(
        id: id,
        collection: Collection.Attendance,
        data: Attendance(
          id: id,
          name: userName,
          nign: prov.user?.id,
          imageUrlIn: type == 'in' ? imageUrl : _attendance?.imageUrlIn,
          imageUrlOut: type == 'out' ? imageUrl : null,
          dateIn: type == 'in' ? currentDate : _attendance?.dateIn,
          dateOut: type == 'out' ? currentDate : null,
        ),
      );
      if (type == 'in') {
        _attendance = Attendance(
          imageUrlIn: imageUrl,
          dateIn: currentDate,
        );
        _isAttend = true;
      } else {
        _attendance = Attendance(
          imageUrlIn: _attendance?.imageUrlIn,
          imageUrlOut: imageUrl,
          dateIn: _attendance?.dateIn,
          dateOut: currentDate,
        );
        _isAttend = false;
      }
      notifyListeners();
      return response;
    } catch (e) {
      throw e;
    }
  }
}
