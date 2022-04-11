import 'package:attendance/models/absent.dart';
import 'package:attendance/models/response.dart';
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

  Future<void> sendReason(
      BuildContext context, String id, String reason) async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    try {
      final currentDate = DateTime.now();
      final userName = prov.user?.name;
      final id = '${userName}_${currentDate.formatddMMy()}';
      final response = await FirebaseService.set(
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
      _absent = response.value;
    } catch (e) {
      throw e;
    }
  }
}
