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

  void resetState() {
    _isAttend = false;
    _attendances = null;
    notifyListeners();
  }

  Future<void> getAttendances() async {
    try {
      final response = await FirebaseService.get<List<Attendance>>(
          collection: Collection.Attendance, data: Attendance());
      if (response.value != null || response.value!.isNotEmpty) {
        _attendances = response.value;
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
        if (response.value?.get('date_out') != null) {
          _isAttend = false;
        }
        _isAttend = true;
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<Response<T>> upload<T>(
    BuildContext context,
    XFile file,
    String type,
  ) async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    try {
      final currentDate = DateTime.now();
      final userName = prov.user?.name ?? '';
      final id = '${userName}_${currentDate.formatddMMy()}';
      final fileName = '${userName}_${currentDate.millisecondsSinceEpoch}';
      final imageUrl = await FirebaseService.uploadImage(file, fileName);
      final response = await FirebaseService.set<T>(
        id: id,
        collection: Collection.Attendance,
        data: Attendance(
          id: id,
          name: userName,
          nign: prov.user?.id,
          imageUrl: imageUrl,
          dateIn: type == 'in' ? currentDate : null,
          dateOut: type == 'out' ? currentDate : null,
        ),
      );
      _isAttend = true;
      notifyListeners();
      return response;
    } catch (e) {
      throw e;
    }
  }
}
