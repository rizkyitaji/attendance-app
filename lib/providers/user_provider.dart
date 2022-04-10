import 'package:attendance/models/response.dart';
import 'package:attendance/models/user.dart';
import 'package:attendance/providers/attendance_provider.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  List<User>? _users;
  List<User>? get users {
    if (_users == null) return null;
    final list = _users ?? [];
    return list.where((e) => e.level == Level.User).toList();
  }

  void resetState() {
    _user = null;
    _users = null;
    notifyListeners();
  }

  Future<Response<DocumentSnapshot>> getUser(String id) async {
    try {
      final response = await FirebaseService.get<DocumentSnapshot>(
          collection: Collection.Users, id: id);
      if (response.value != null) {
        _user = User.fromSnapshot(response.value!);
        return response;
      }
      return Response(message: 'Gagal mendapatkan data user');
    } catch (e) {
      throw e;
    }
  }

  Future<void> getUsers(int limit) async {
    try {
      final response = await FirebaseService.get<List<DocumentSnapshot>>(
          collection: Collection.Users, limit: limit);
      final snapshots = response.value ?? [];
      if (snapshots.isNotEmpty) {
        _users = snapshots.map((e) => User.fromSnapshot(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<String> login(String id, String password) async {
    try {
      final response = await getUser(id);
      if (!response.value!.exists) {
        return 'NIGN Anda salah atau tidak terdaftar';
      } else {
        if (password.compareTo(response.value!.get('password')) == 0) {
          final pref = await SharedPreferences.getInstance();
          pref.setString('user', _user?.id ?? '');
          return 'Selamat Datang';
        } else {
          return 'Password Anda salah atau tidak terdaftar';
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      final pref = await SharedPreferences.getInstance();
      pref.clear();

      final attendanceProv =
          Provider.of<AttendanceProvider>(context, listen: false);
      attendanceProv.resetState();
      resetState();
    } catch (e) {
      throw e;
    }
  }
}
