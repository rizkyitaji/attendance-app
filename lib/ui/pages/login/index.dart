import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/assets.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/ui/widgets/loading_dialog.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _cNign = TextEditingController(), _cPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  void dispose() {
    _cNign.dispose();
    _cPassword.dispose();
    super.dispose();
  }

  void _login() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      showLoadingDialog(context);
      try {
        final result = await prov.login(
          _cNign.text.trim(),
          _cPassword.text.trim(),
        );
        if (!mounted) return;
        Navigator.pop(context);
        showSnackBar(context, result);
        if (result == 'Selamat Datang')
          Navigator.pushReplacementNamed(context, homeRoute);
      } catch (e) {
        if (!mounted) return;
        Navigator.pop(context);
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(40),
                  children: [
                    Image.asset(iconLogo, height: 140),
                    SizedBox(height: 40),
                    Text(
                      'SISTEM ABSENSI DOSEN',
                      textAlign: TextAlign.center,
                      style: poppinsBlackw600.copyWith(fontSize: 25),
                    ),
                    Text(
                      'FAKULTAS TEKNIK\nUNIVERSITAS PELITA BANGSA',
                      textAlign: TextAlign.center,
                      style: poppinsBlackw400.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _cNign,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      style: poppinsBlackw400.copyWith(fontSize: 14),
                      validator: (value) {
                        if (value!.isEmpty) return 'Field ini harus diisi';
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'NIDN',
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: _cPassword,
                      obscureText: _isObscure,
                      textInputAction: TextInputAction.done,
                      style: poppinsBlackw400.copyWith(fontSize: 14),
                      onChanged: (value) {
                        if (value.isNotEmpty) _formKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Field ini harus diisi';
                        if (value.length < 6)
                          return 'Kata sandi minimal harus 6 karakter';
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'SANDI',
                        suffixIcon: InkWell(
                          onTap: () => setState(() => _isObscure = !_isObscure),
                          child: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 32),
              child: ElevatedButton(
                onPressed: _login,
                child: Text('Masuk'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
