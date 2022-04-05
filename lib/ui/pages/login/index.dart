import 'package:attendance/services/assets.dart';
import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = false;

  void _login() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(40),
          child: Column(
            key: _formKey,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconLogo, height: 140),
              SizedBox(height: 40),
              Text(
                'SISTEM ABSENSI GURU',
                textAlign: TextAlign.center,
                style: poppinsBlackw600.copyWith(fontSize: 25),
              ),
              Text(
                'SDN SUKAKERTA 03',
                textAlign: TextAlign.center,
                style: poppinsBlackw400.copyWith(fontSize: 20),
              ),
              SizedBox(height: 40),
              TextFormField(
                keyboardType: TextInputType.number,
                style: poppinsBlackw400.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  labelText: 'NIGN',
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                obscureText: _isObscure,
                style: poppinsBlackw400.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  labelText: 'SANDI',
                  suffixIcon: InkWell(
                    onTap: () => setState(() => _isObscure = !_isObscure),
                    child: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: _login,
                child: Center(
                  child: Text('Masuk'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
