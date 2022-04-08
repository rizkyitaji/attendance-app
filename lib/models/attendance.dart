import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  String? id, name;
  DateTime? date;

  Attendance.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    date = DateTime.fromMillisecondsSinceEpoch(snapshot['date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date?.millisecondsSinceEpoch,
    };
  }
}
