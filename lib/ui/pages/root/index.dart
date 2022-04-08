import 'package:attendance/router/constants.dart';
import 'package:attendance/services/assets.dart';
import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootPage extends StatelessWidget {
  Future<void> _navigate(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    final isLogin = pref.getString('user') ?? '';
    Future.delayed(Duration(seconds: 2)).then((_) {
      if (isLogin.isNotEmpty) {
        Navigator.pushReplacementNamed(context, homeRoute);
      } else {
        Navigator.pushReplacementNamed(context, loginRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _navigate(context),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: blue,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(iconLogo, height: 140),
                SizedBox(height: 32),
                Text(
                  'SISTEM ABSENSI GURU',
                  style: poppinsWhitew600.copyWith(fontSize: 25),
                ),
                Text(
                  'SDN SUKAKERTA 03',
                  textAlign: TextAlign.center,
                  style: poppinsWhitew300.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
