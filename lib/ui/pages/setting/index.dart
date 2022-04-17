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
<<<<<<< HEAD

    try {
      if (_formKey.currentState!.validate()) {
        await prov.update(prov.user?.id ?? '-', _cNewPassword2.text.trim());
        Navigator.pop(context);
        showSnackBar(context, "Kata sandi berhasil diubah");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
=======
    if (_formKey.currentState!.validate()) {
      try {
        await prov.update(_cNewPassword2.text.trim());
        if (!mounted) return;
        Navigator.pop(context);
        showSnackBar(context, "Kata sandi berhasil diubah");
      } catch (e) {
        if (!mounted) return;
        showSnackBar(context, e.toString());
      }
>>>>>>> b933595e3f4fa99d45b8bbf670778f2503a36f8a
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "PENGATURAN",
      ),
      body: Form(
        key: _formKey,
<<<<<<< HEAD
        child: Consumer<UserProvider>(builder: (context, prov, _) {
          final provPass = prov.user?.password;
          return ListView(
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
                "KATA SANDI LAMA",
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
                  if (value != provPass) return 'Kata sandi lama salah';

                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "KATA SANDI BARU",
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
                "ULANGI KATA SANDI BARU",
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
                    return 'Kata sandi tidak sama';
                  if (value!.isEmpty) return 'Field ini harus diisi';
                  if (value.length < 6)
                    return 'Minimal kata sandi harus 6 karakter';
                  return null;
                },
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: _changePassword,
                child: Text('SIMPAN'),
              ),
            ],
          );
        }),
=======
        child: Consumer<UserProvider>(
          builder: (context, prov, _) {
            final user = prov.user;
            final password = user?.password;

            return ListView(
              padding: EdgeInsets.all(24),
              children: [
                Text(
                  user?.name ?? '-',
                  style: poppinsBlackw600.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  user?.id ?? '-',
                  style: poppinsBlackw600.copyWith(
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "KATA SANDI LAMA",
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
                      onTap: () => setState(() => _isObscure = !_isObscure),
                      child: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
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
                  style: poppinsBluew500.copyWith(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  obscureText: _isObscure,
                  controller: _cNewPassword1,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () => setState(() => _isObscure = !_isObscure),
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
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () => setState(() => _isObscure = !_isObscure),
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
                    if (value.trim() != _cNewPassword1.text.trim())
                      return 'Kata sandi tidak sama';
                    if (value.length < 6)
                      return 'Kata sandi minimal harus 6 karakter';
                    return null;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: _changePassword,
                  child: Text('Simpan'),
                ),
              ],
            );
          },
        ),
>>>>>>> b933595e3f4fa99d45b8bbf670778f2503a36f8a
      ),
    );
  }
}
