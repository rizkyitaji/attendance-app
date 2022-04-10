import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _cOldPassword = TextEditingController(),
      _cNewPassword1 = TextEditingController(),
      _cNewPassword2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  void _ubahPassword() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    if (_cOldPassword.text.trim().compareTo(prov.user?.password ?? '-') == 0 &&
        _cNewPassword1.text.trim() != "" &&
        _cNewPassword2.text.trim() != "") {
      if (_cNewPassword1.text.trim().compareTo(_cNewPassword2.text.trim()) ==
          0) {
        try {
          final result = await prov.update(
              prov.user?.id ?? '-', _cNewPassword2.text.trim());

          Navigator.pop(context);
          showSnackBar(context, "Password berhasil diubah");
        } catch (e) {}
      } else {
        showSnackBar(context, "Password baru tidak sama");
      }
    } else {
      showSnackBar(context, "Password tidak boleh kosong");
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "PENGATURAN",
        showLogout: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            Text(
              prov.user?.name ?? '-',
              style: poppinsBlackw600.copyWith(
                fontSize: 16,
              ),
            ),
            Text(
              prov.user?.id ?? '-',
              style: poppinsBlackw600.copyWith(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Kata Sandi Lama".toUpperCase(),
              style: poppinsBluew500.copyWith(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              obscureText: _isObscure,
              controller: _cOldPassword,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    _isObscure = !_isObscure;
                  }),
                  child: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) _formKey.currentState!.validate();
              },
              validator: (value) {
                if (value != prov.user?.password) return 'Password Lama Salah';

                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Kata Sandi Baru".toUpperCase(),
              style: poppinsBluew500.copyWith(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              obscureText: _isObscure,
              controller: _cNewPassword1,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    _isObscure = !_isObscure;
                  }),
                  child: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) _formKey.currentState!.validate();
              },
              validator: (value) {
                if (value!.isEmpty) return 'Field ini harus diisi';
                if (value.length < 6)
                  return 'Minimal password harus 6 karakter';
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Ulangi Kata Sandi Baru".toUpperCase(),
              style: poppinsBluew500.copyWith(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              obscureText: _isObscure,
              controller: _cNewPassword2,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    _isObscure = !_isObscure;
                  }),
                  child: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) _formKey.currentState!.validate();
              },
              validator: (value) {
                if (value != _cNewPassword1.text.trim())
                  return 'Kata Sandi Tidak Sama';
                if (value!.isEmpty) return 'Field ini harus diisi';
                if (value.length < 6)
                  return 'Minimal password harus 6 karakter';
                return null;
              },
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                _ubahPassword();
              },
              child: Text('SIMPAN'),
            ),
          ],
        ),
      ),
    );
  }
}
