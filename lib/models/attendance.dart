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

  factory Attendance.fromSnapshot(DocumentSnapshot snapshot) {
    final value = snapshot.data() as Map<String, dynamic>;
    return Attendance.fromMap(value);
  }

  Attendance.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    nign = map['nign'];
    imageUrlIn = map['image_url_in'];
    imageUrlOut = map['image_url_out'];
    if (map['date_in'] != null)
      dateIn = DateTime.fromMillisecondsSinceEpoch(map['date_in']);
    if (map['date_out'] != null)
      dateOut = DateTime.fromMillisecondsSinceEpoch(map['date_out']);
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
