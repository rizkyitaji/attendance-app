import 'package:attendance/services/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id, password, name;
  Level? level;

  User({
    this.id,
    this.name,
    this.password,
    this.level,
  });

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    final value = snapshot.data() as Map<String, dynamic>;
    return User.fromMap(value);
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    password = map['password'];
    name = map['name'];
    level = map['level'] == 'user' ? Level.User : Level.Admin;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'name': name,
      'level': level == Level.Admin ? 'admin' : 'user',
    };
  }
}
