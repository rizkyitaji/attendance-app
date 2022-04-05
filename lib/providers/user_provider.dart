import 'package:attendance/models/user.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  Future<String> login(String id, String password) async {
    try {
      final response = await FirebaseService.get<DocumentSnapshot>(
          collection: Collection.Users, data: User, id: id);
      if (!response.value!.exists) {
        return 'NIGN Anda salah atau tidak terdaftar';
      } else {
        if (password.compareTo(response.value!.get('password')) == 0) {
          return 'Selamat Datang';
        } else {
          return 'Password Anda salah atau tidak terdaftar';
        }
      }
    } catch (e) {
      throw e;
    }
  }
}
