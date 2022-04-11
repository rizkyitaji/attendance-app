import 'package:attendance/models/absent.dart';
import 'package:attendance/models/response.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:attendance/services/utils.dart';

class AbsentProvider extends ChangeNotifier {
  Absent? _absent;
  Absent? get absent => _absent;

  Future<Response<T>> sendReason<T>(
      BuildContext context, String id, String reason) async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    try {
      final currentDate = DateTime.now();
      final userName = prov.user?.name;
      final id = '${userName}_${currentDate.formatddMMy()}';
      final response = await FirebaseService.set<T>(
        id: id,
        collection: Collection.Absent,
        data: Absent(
          id: id,
          name: userName,
          reason: reason,
          date: currentDate,
        ),
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
