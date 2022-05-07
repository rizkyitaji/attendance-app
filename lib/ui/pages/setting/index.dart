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

  void _changePassword() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      try {
        await prov.updateUser(newPassword: _cNewPassword2.text.trim());
        if (!mounted) return;
        Navigator.pop(context);
        showSnackBar(context, "Kata sandi berhasil diubah");
      } catch (e) {
        if (!mounted) return;
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "PENGATURAN"),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: Consumer<UserProvider>(
                builder: (context, prov, _) {
                  final user = prov.user;
                  final password = user?.password;

                  return ListView(
                    padding: EdgeInsets.all(24),
                    children: [
                      Text(
                        user?.name ?? '-',
                        style: poppinsBlackw600.copyWith(fontSize: 16),
                      ),
                      Text(
                        user?.nign ?? '-',
                        style: poppinsBlackw600.copyWith(fontSize: 12),
                      ),
                      SizedBox(height: 70),
                      Text(
                        "KATA SANDI LAMA",
                        style: poppinsBluew500.copyWith(fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        obscureText: _isObscure,
                        controller: _cOldPassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () =>
                                setState(() => _isObscure = !_isObscure),
                            child: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty)
                            _formKey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'Field ini harus diisi';
                          if (value != password) return 'Kata sandi lama salah';
                          if (value.length < 6)
                            return 'Kata sandi minimal harus 6 karakter';
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "KATA SANDI BARU",
                        style: poppinsBluew500.copyWith(fontSize: 15),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        obscureText: _isObscure,
                        controller: _cNewPassword1,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () =>
                                setState(() => _isObscure = !_isObscure),
                            child: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty)
                            _formKey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'Field ini harus diisi';
                          if (value.length < 6)
                            return 'Kata sandi minimal harus 6 karakter';
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        "ULANGI KATA SANDI BARU",
                        style: poppinsBluew500.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        obscureText: _isObscure,
                        controller: _cNewPassword2,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () =>
                                setState(() => _isObscure = !_isObscure),
                            child: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty)
                            _formKey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'Field ini harus diisi';
                          if (value.trim() != _cNewPassword1.text.trim())
                            return 'Kata sandi tidak sama';
                          if (value.length < 6)
                            return 'Kata sandi minimal harus 6 karakter';
                          return null;
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: ElevatedButton(
              onPressed: _changePassword,
              child: Text('Simpan'),
            ),
          )
        ],
      ),
    );
  }
}
