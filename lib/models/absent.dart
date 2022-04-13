import 'package:cloud_firestore/cloud_firestore.dart';

class Absent {
  String? id, name, nign, reason;
  DateTime? date;

  Absent({
    this.id,
    this.name,
    this.nign,
    this.reason,
    this.date,
  });

  factory Absent.fromSnapshot(DocumentSnapshot snapshot) {
    final value = snapshot.data() as Map<String, dynamic>;
    return Absent.fromMap(value);
  }

  Absent.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    nign = map['nign'];
    reason = map['reason'];
    date = DateTime.fromMillisecondsSinceEpoch(map['date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nign': nign,
      'reason': reason,
      'date': date?.millisecondsSinceEpoch,
    };
  }
}
