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

  String? _nign;
  String? get nign => _nign;
  set nign(String? value) {
    _nign = value;
    notifyListeners();
  }

  void resetState() {
    _user = null;
    _users = null;
    _nign = null;
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
      final response = await FirebaseService.get<List<DocumentSnapshot>>(
          collection: Collection.Users, limit: 1, filter: 'nign', query: id);
      final snapshots = response.value ?? [];
      if (snapshots.isEmpty) {
        return 'NIGN Anda salah atau tidak terdaftar';
      } else {
        if (password.compareTo(snapshots[0].get('password')) == 0) {
          final pref = await SharedPreferences.getInstance();
          _user = User.fromSnapshot(snapshots[0]);
          pref.setString('id', _user?.id ?? '');
          return 'Selamat Datang';
        } else {
          return 'Kata sandi Anda salah atau tidak terdaftar';
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      final attendanceProv =
          Provider.of<AttendanceProvider>(context, listen: false);
      final absentProv =
          Provider.of<AttendanceProvider>(context, listen: false);
      final pref = await SharedPreferences.getInstance();
      pref.clear();

      attendanceProv.resetState();
      absentProv.resetState();
      resetState();
    } catch (e) {
      throw e;
    }
  }

  Future<void> update(String password) async {
    try {
      final response = await FirebaseService.set<User>(
        id: _user?.id,
        collection: Collection.Users,
        data: User(
          id: _user?.id,
          name: _user?.name,
          level: _user?.level,
          password: password,
        ),
      );
      _user = response;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(
      {String? id, String? nign, String? name, String? newPassword}) async {
    try {
      if (nign == null && name == null) {
        final response = await FirebaseService.set<User>(
          id: _user?.id,
          collection: Collection.Users,
          data: User(
            id: _user?.id,
            nign: _user?.nign,
            name: user?.name,
            level: user?.level,
            password: newPassword,
          ),
        );
        _user = response;
        notifyListeners();
      } else {
        await FirebaseService.set<User>(
          collection: Collection.Users,
          id: id,
          data: User(
            id: id,
            nign: nign,
            name: name,
            level: Level.User,
            password: newPassword,
          ),
        );
      }
    } catch (e) {
      throw e;
    }
  }
}
