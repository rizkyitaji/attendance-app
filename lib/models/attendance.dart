import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  String? id, name, nign, imageUrl;
  DateTime? dateIn, dateOut;

  Attendance({
    this.id,
    this.name,
    this.nign,
    this.imageUrl,
    this.dateIn,
    this.dateOut,
  });

  Attendance.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    nign = snapshot['nign'];
    imageUrl = snapshot['image_url'];
    if (snapshot['date_in'] != null)
      dateIn = DateTime.fromMillisecondsSinceEpoch(snapshot['date_in']);
    if (snapshot['date_out'] != null)
      dateOut = DateTime.fromMillisecondsSinceEpoch(snapshot['date_out']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nign': nign,
      'image_url': imageUrl,
      'date_in': dateIn?.millisecondsSinceEpoch,
      'date_out': dateOut?.millisecondsSinceEpoch,
    };
  }
}
