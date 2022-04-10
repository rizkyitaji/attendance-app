import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  String? id, name, nign, imageUrlIn, imageUrlOut;
  DateTime? dateIn, dateOut;

  Attendance({
    this.id,
    this.name,
    this.nign,
    this.imageUrlIn,
    this.imageUrlOut,
    this.dateIn,
    this.dateOut,
  });

  Attendance copyWith({
    String? id,
    String? name,
    String? nign,
    String? imageUrlIn,
    String? imageUrlOut,
    DateTime? dateIn,
    DateTime? dateOut,
  }) =>
      Attendance(
        id: id ?? this.id,
        name: name ?? this.name,
        nign: nign ?? this.nign,
        imageUrlIn: imageUrlIn ?? this.imageUrlIn,
        imageUrlOut: imageUrlOut ?? this.imageUrlOut,
        dateIn: dateIn ?? this.dateIn,
        dateOut: dateOut ?? this.dateOut,
      );

  Attendance.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    nign = snapshot['nign'];
    imageUrlIn = snapshot['image_url_in'];
    imageUrlOut = snapshot['image_url_out'];
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
      'image_url_in': imageUrlIn,
      'image_url_out': imageUrlOut,
      'date_in': dateIn?.millisecondsSinceEpoch,
      'date_out': dateOut?.millisecondsSinceEpoch,
    };
  }
}
