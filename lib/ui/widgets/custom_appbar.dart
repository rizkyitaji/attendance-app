import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
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
    try {
      await prov.logout(context).then((_) {
        Navigator.pushReplacementNamed(context, loginRoute);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Image.asset(iconLogo),
      ),
      title: Text(title ?? ''),
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
