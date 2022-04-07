import 'package:attendance/services/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id, password, name;
  Level? level;

  User.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    password = snapshot['password'];
    name = snapshot['name'];
    level = snapshot['level'] == 'User' ? Level.User : Level.Admin;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'name': name,
      'level': level == Level.User ? 'User' : 'Admin',
    };
  }
}
