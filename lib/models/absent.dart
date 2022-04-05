import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Absent {
  String? id, name, reason;
  DateTime? date;

  Absent.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    reason = snapshot['reason'];
    date = DateTime.fromMillisecondsSinceEpoch(snapshot['date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'reason': reason,
      'date': date?.millisecondsSinceEpoch,
    };
  }
}
