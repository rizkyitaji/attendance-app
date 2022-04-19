import 'package:attendance/models/user.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final User? argument;
  ProfilePage({this.argument});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _cName = TextEditingController(),
      _cNign = TextEditingController(),
      _cPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  void initState() {
    _cName.text = widget.argument?.name ?? '-';
    _cNign.text = widget.argument?.id ?? '-';
    _cPass.text = widget.argument?.password ?? '-';
    super.initState();
  }

  void _updateData() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    final _nign = _cNign.text.trim();
    final _name = _cName.text.trim();
    final _pass = _cPass.text.trim();
    if (_formKey.currentState!.validate()) {
      User user = User(id: _nign, name: _name, password: _pass);
      try {
        {
          await prov.updateUser(
            _nign,
            _name,
            _pass,
          );
        }

        Navigator.pop(context, user);
        showSnackBar(context, "Berhasil");
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Profil"),
        body: Form(
          key: _formKey,
          child: Consumer<UserProvider>(builder: (context, prov, _) {
            final provPass = prov.user?.password;
            return ListView(
              padding: EdgeInsets.all(24),
              children: [
                Text(
                  "UPDATE DATA GURU",
                  style: poppinsBlackw600.copyWith(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "NAMA",
                  style: poppinsBluew500.copyWith(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _cName,
                  decoration: InputDecoration(),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "NIGN",
                  style: poppinsBluew500.copyWith(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _cNign,
                  decoration: InputDecoration(),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "KATA SANDI",
                  style: poppinsBluew500.copyWith(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  obscureText: _isObscure,
                  controller: _cPass,
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
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: _updateData,
                  child: Text('SIMPAN'),
                ),
              ],
            );
          }),
        ));
  }
}
