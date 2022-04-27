import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  String? id, name, userId, imageUrlIn, imageUrlOut, locationIn, locationOut;
  DateTime? dateIn, dateOut;

  Attendance({
    this.id,
    this.name,
    this.userId,
    this.imageUrlIn,
    this.imageUrlOut,
    this.locationIn,
    this.locationOut,
    this.dateIn,
    this.dateOut,
  });

  Attendance copyWith({
    String? id,
    String? name,
    String? userId,
    String? imageUrlIn,
    String? imageUrlOut,
    String? locationIn,
    String? locationOut,
    DateTime? dateIn,
    DateTime? dateOut,
  }) =>
      Attendance(
        id: id ?? this.id,
        name: name ?? this.name,
        userId: userId ?? this.userId,
        imageUrlIn: imageUrlIn ?? this.imageUrlIn,
        imageUrlOut: imageUrlOut ?? this.imageUrlOut,
        locationIn: locationIn ?? this.locationIn,
        locationOut: locationOut ?? this.locationOut,
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
    userId = map['user_id'];
    imageUrlIn = map['image_url_in'];
    imageUrlOut = map['image_url_out'];
    locationIn = map['location_in'];
    locationOut = map['location_out'];
    if (map['date_in'] != null)
      dateIn = DateTime.fromMillisecondsSinceEpoch(map['date_in']);
    if (map['date_out'] != null)
      dateOut = DateTime.fromMillisecondsSinceEpoch(map['date_out']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'image_url_in': imageUrlIn,
      'image_url_out': imageUrlOut,
      'location_in': locationIn,
      'location_out': locationOut,
      'date_in': dateIn?.millisecondsSinceEpoch,
      'date_out': dateOut?.millisecondsSinceEpoch,
    };
  }
}
