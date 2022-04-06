import 'package:attendance/services/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id, password;
  Level? level;

  User.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    password = snapshot['password'];
    level = snapshot['level'] == 'user' ? Level.User : Level.Admin;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'level': level == Level.User ? 'user' : 'admin',
    };
  }
}
