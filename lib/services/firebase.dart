import 'package:attendance/models/response.dart';
import 'package:attendance/services/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static CollectionReference ref(Collection? collection) {
    return firestore.collection(path(collection));
  }

  static String path(Collection? collection) {
    switch (collection) {
      case Collection.Users:
        return 'Users';
      case Collection.Attendance:
        return 'Attendance';
      default:
        return 'Absent';
    }
  }

  static Future<T> set<T>({
    required Collection? collection,
    String? id,
    required dynamic data,
  }) async {
    try {
      if (id != null) {
        await ref(collection).doc(id).set(data.toMap());
      } else {
        await ref(collection).add(data.toMap()).then((value) {
          data.id = value.id;
          value.set(data.toMap());
        });
      }
      return data;
    } catch (e) {
      throw e;
    }
  }

  static Future<Response<T>> get<T>({
    required Collection collection,
    int limit = 10,
    String? filter,
    String? query,
    String? id,
  }) async {
    try {
      dynamic result;
      if (id != null) {
        result = await ref(collection).doc(id).get();
      } else {
        late QuerySnapshot querySnapshot;
        if (filter != null) {
          querySnapshot = await ref(collection)
              .limit(limit)
              .where(filter, isEqualTo: query)
              .get();
        } else {
          querySnapshot = await ref(collection).limit(limit).get();
        }
        result = querySnapshot.docs;
      }
      return Response(value: result);
    } catch (e) {
      throw e;
    }
  }

  static Future<Response<bool>> delete({
    required Collection? collection,
    required String? id,
  }) async {
    try {
      await ref(collection).doc(id).delete();
      return Response(
        value: true,
        message: 'Data berhasil dihapus',
      );
    } catch (e) {
      throw e;
    }
  }

  static Future<String> uploadImage(XFile file, String name) async {
    try {
      var imageFile = await file.readAsBytes();

      UploadTask task = storage
          .ref('images/$name.jpg')
          .putData(imageFile, SettableMetadata(contentType: 'image/jpeg'));

      String url = await task.then((value) {
        return value.ref.getDownloadURL();
      });
      return url;
    } catch (e) {
      throw e;
    }
  }
}
