import 'package:attendance/models/response.dart';
import 'package:attendance/services/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static CollectionReference ref(Table? table) {
    return firestore.collection(path(table));
  }

  static String path(Table? table) {
    switch (table) {
      case Table.Users:
        return 'Users';
      case Table.Attendance:
        return 'Attendance';
      case Table.Absent:
        return 'Absent';
      default:
        return 'Teacher';
    }
  }

  static Future<Response<T>> set<T>({
    required Table? table,
    String? id,
    required dynamic data,
  }) async {
    try {
      if (id != null) {
        await ref(table).add({}).then((value) {
          data.id = value.id;
          value.set(data.toMap());
        });
      } else {
        await ref(table).doc(id).set(data.toMap());
      }
      return Response(
        value: data,
        message: 'Data berhasil ditambahkan',
      );
    } catch (e) {
      return Response(message: '$e');
    }
  }

  static Future<Response<T>> get<T>({
    required Table? table,
    String? id,
    required dynamic data,
  }) async {
    try {
      dynamic list;
      if (id != null) {
        list = await ref(table).doc(id).get();
      } else {
        var query = await ref(table).get();
        list = query.docs.map((e) => data.fromSnapshot(e)).toList();
      }
      return Response(value: list);
    } catch (e) {
      return Response(message: '$e');
    }
  }

  static Future<Response<T>> delete<T>({
    required Table? table,
    required String? id,
  }) async {
    try {
      await ref(table).doc(id).delete();
      return Response(message: 'Data berhasil dihapus');
    } catch (e) {
      return Response(message: '$e');
    }
  }

  static Future<Response<String>> uploadImage(
      PickedFile file, String name) async {
    try {
      var imageFile = await file.readAsBytes();

      UploadTask task = storage
          .ref('images/$name.jpg')
          .putData(imageFile, SettableMetadata(contentType: 'image/jpeg'));

      String url = await task.then((value) {
        return value.ref.getDownloadURL();
      });
      return Response(value: url);
    } catch (e) {
      return Response(message: '$e');
    }
  }
}
