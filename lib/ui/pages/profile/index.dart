import 'package:attendance/models/user.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/assets.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      _cPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _cName.text = widget.argument?.name ?? '';
    _cNign.text = widget.argument?.id ?? '';
    _cPassword.text = widget.argument?.password ?? '';
  }

  void _setData() async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    final _nign = _cNign.text.trim();
    final _name = _cName.text.trim();
    final _password = _cPassword.text.trim();
    final user = User(id: _nign, name: _name, password: _password);

    if (_formKey.currentState!.validate()) {
      try {
        await prov.updateUser(_nign, _name, _password);
        if (!mounted) return;
        Navigator.pop(context, user);
        showSnackBar(context, "Berhasil");
      } catch (e) {
        if (!mounted) return;
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profil"),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(24),
                children: [
                  SvgPicture.asset(
                    illustrationProfile,
                    width: 200,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "NAMA",
                    style: poppinsBluew500.copyWith(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _cName,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "NIGN",
                    style: poppinsBluew500.copyWith(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _cNign,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "KATA SANDI",
                    style: poppinsBluew500.copyWith(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    controller: _cPassword,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      if (value.isNotEmpty) _formKey.currentState!.validate();
                    },
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
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: ElevatedButton(
              onPressed: _setData,
              child: Text('Simpan'),
            ),
          ),
        ],
      ),
    );
  }
}
