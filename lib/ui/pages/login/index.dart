import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/assets.dart';
import 'package:attendance/services/themes.dart';
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
  bool _isObscure = false;

  @override
  void dispose() {
    _cNign.dispose();
    _cPassword.dispose();
    super.dispose();
  }

  void _login() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      try {
        final result = await prov.login(
          _cNign.text.trim(),
          _cPassword.text.trim(),
        );
        if (!mounted) return;
        showSnackBar(context, result);
      } catch (e) {
        if (!mounted) return;
        showSnackBar(context, e.toString());
      }
    }
  }

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
                controller: _cNign,
                keyboardType: TextInputType.number,
                style: poppinsBlackw400.copyWith(fontSize: 14),
                validator: (value) {
                  if (value!.isEmpty) return 'Field ini harus diisi';
                },
                decoration: InputDecoration(
                  labelText: 'NIGN',
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _cPassword,
                obscureText: _isObscure,
                style: poppinsBlackw400.copyWith(fontSize: 14),
                onChanged: (value) {
                  if (value.isNotEmpty) _formKey.currentState!.validate();
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Field ini harus diisi';
                  if (value.length < 6)
                    return 'Minimal password harus 6 karakter';
                },
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
