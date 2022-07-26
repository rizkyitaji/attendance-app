import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/ui/widgets/loading_dialog.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogout;

  CustomAppBar({
    this.title,
    this.showLogout = false,
  });

  void _logout(BuildContext context) async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    showLoadingDialog(context);
    try {
      await Future.delayed(Duration(milliseconds: 500)).then((_) async {
        await prov.logout(context).then((_) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, loginRoute);
        });
      });
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Image.asset(
          iconLogoCircle,
          fit: BoxFit.cover,
        ),
      ),
      title: Text((title ?? '').toUpperCase()),
      actions: [
        Visibility(
          visible: showLogout,
          child: IconButton(
            onPressed: () => _logout(context),
            icon: Icon(Icons.logout),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
