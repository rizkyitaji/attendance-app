import 'package:attendance/models/user.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  //buat variable _user di kelas User? yg ada di model
  User? _user;
  //get si _user
  User? get user => _user;

  Future<String> login(String id, String password) async {
    try {
      //var response => ngambil data yg ada di firebase,
      final response = await FirebaseService.get<DocumentSnapshot>(
          //ada parameter yg dibawa
          collection: Collection.Users,
          data: User,
          id: id);
      //kalo nilai dari variabel tidak ada
      if (!response.value!.exists) {
        return 'NIGN Anda salah atau tidak terdaftar';
      } else {
        // dicompare password dari login sama dari firebase kalo sama
        if (password.compareTo(response.value!.get('password')) == 0) {
          _user = User.fromSnapshot(response.value!);
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
