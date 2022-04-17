import 'package:attendance/models/absent.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:attendance/services/utils.dart';

class AbsentProvider extends ChangeNotifier {
  bool _isAbsent = false;
  bool get isAbsent => _isAbsent;
  set isAbsent(bool value) {
    _isAbsent = value;
    notifyListeners();
  }

  Absent? _absent;
  Absent? get absent => _absent;

<<<<<<< HEAD
  Future<void> sendReason(
      BuildContext context, String id, String reason) async {
=======
  void resetState() {
    _isAbsent = false;
    _absent = null;
    notifyListeners();
  }

  Future<void> sendReason(
    BuildContext context,
    String reason,
  ) async {
>>>>>>> b933595e3f4fa99d45b8bbf670778f2503a36f8a
    final prov = Provider.of<UserProvider>(context, listen: false);
    try {
      final currentDate = DateTime.now();
      final userName = prov.user?.name;
      final id = '${userName}_${currentDate.formatddMMy()}';
<<<<<<< HEAD
      final response = await FirebaseService.set(
=======
      final response = await FirebaseService.set<Absent>(
>>>>>>> b933595e3f4fa99d45b8bbf670778f2503a36f8a
        id: id,
        collection: Collection.Absent,
        data: Absent(
          id: id,
          name: userName,
          reason: reason,
          date: currentDate,
        ),
      );
      isAbsent = !isAbsent;
<<<<<<< HEAD
      _absent = response.value;
=======
      _absent = response;
      notifyListeners();
>>>>>>> b933595e3f4fa99d45b8bbf670778f2503a36f8a
    } catch (e) {
      throw e;
    }
  }
}
