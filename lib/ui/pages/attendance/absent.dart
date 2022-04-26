import 'package:attendance/models/absent.dart';
import 'package:attendance/providers/absent_provider.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance/services/utils.dart';

class AbsentPage extends StatefulWidget {
  final Absent? argument;

  AbsentPage({this.argument});

  @override
  _AbsentPageState createState() => _AbsentPageState();
}

class _AbsentPageState extends State<AbsentPage> {
  final _formKey = GlobalKey<FormFieldState>();
  final _cReason = TextEditingController();
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.argument?.reason != null)
      _cReason.text = widget.argument?.reason ?? '';
  }

  void _send() async {
    final prov = Provider.of<AbsentProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      try {
        await prov.sendReason(context, _cReason.text.trim());
        if (!mounted) return;
        Navigator.pop(context);
        showSnackBar(context, "Pengajuan izin telah dikirim");
      } catch (e) {
        if (!mounted) return;
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "IZIN",
      ),
      body: Consumer<UserProvider>(
        builder: (context, prov, _) {
          final user = prov.user;

          return ListView(
            padding: EdgeInsets.all(24),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (widget.argument?.name ?? user?.name ?? '-')
                            .capitalize(),
                        style: poppinsBlackw600.copyWith(fontSize: 16),
                      ),
                      Text(
                        (widget.argument?.nign ?? user?.id ?? '-').capitalize(),
                        style: poppinsBlackw600.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  Visibility(
                    visible: user?.level == Level.User,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, settingRoute),
                      child: Icon(Icons.settings),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "ALASAN TIDAK MASUK",
                style: poppinsBlackw400.copyWith(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                key: _formKey,
                controller: _cReason,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                maxLines: 8,
                validator: (value) {
                  if (value!.isEmpty) return 'Field ini harus diisi';
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _currentDate.formatMMMMddy(),
                    style: poppinsBlackw400.copyWith(fontSize: 15),
                  ),
                  Text(
                    _currentDate.formathhmm(),
                    style: poppinsBlackw400.copyWith(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Visibility(
                visible: (widget.argument?.reason ?? '').isEmpty,
                child: ElevatedButton(
                  onPressed: _send,
                  child: Text("Kirim"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
