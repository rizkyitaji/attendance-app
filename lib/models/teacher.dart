import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  String? id, name, password;

  Teacher.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    password = snapshot['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
    };
  }
}
