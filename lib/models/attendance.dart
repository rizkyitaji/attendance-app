import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  String? id, name;
  DateTime? dateIn, dateOut;

  Attendance.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    dateIn = DateTime.fromMillisecondsSinceEpoch(snapshot['dateIn']);
    dateOut = DateTime.fromMillisecondsSinceEpoch(snapshot['dateOut']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dateIn': dateIn?.millisecondsSinceEpoch,
      'dateOut': dateOut?.millisecondsSinceEpoch,
    };
  }
}
