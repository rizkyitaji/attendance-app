import 'package:attendance/models/response.dart';
import 'package:attendance/models/user.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/ui/pages/home/admin.dart';
import 'package:attendance/ui/pages/home/user.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  Future<Response<User?>> _getUser(BuildContext context) async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    final pref = await SharedPreferences.getInstance();
    final id = pref.getString('id') ?? '';
    if (prov.user == null) {
      try {
        await prov.getUser(id);
        if (prov.user != null) {
          return Response(value: prov.user);
        }
        Navigator.pushReplacementNamed(context, loginRoute);
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
    return Response(value: prov.user);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response<User?>>(
      future: _getUser(context),
      builder: (context, snapshot) {
        final user = snapshot.data?.value;

        if (user != null) {
          if (user.level == Level.Admin) {
            return AdminHomePage();
          }
          return UserHomePage();
        }
        return SizedBox();
      },
    );
  }
}
