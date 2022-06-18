import 'dart:io';
import 'package:attendance/models/absent.dart';
import 'package:attendance/providers/absent_provider.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/enums.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/ui/pages/attendance/widgets/border_network_image.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  String? _imageReason;

  @override
  void initState() {
    super.initState();
    if (widget.argument?.reason != null)
      _cReason.text = widget.argument?.reason ?? '';
    if (widget.argument?.imageReason != null)
      _imageReason = widget.argument?.imageReason ?? '';
  }

  void _send() async {
    final prov = Provider.of<AbsentProvider>(context, listen: false);
    final file = XFile(_imageReason ?? '');
    final reason = _cReason.text.trim();
    if (_formKey.currentState!.validate()) {
      if (_imageReason != null) {
        try {
          await prov.sendReason(context, reason, file);
          if (!mounted) return;
          Navigator.pop(context);
          showSnackBar(context, "Pengajuan izin telah dikirim");
        } catch (e) {
          if (!mounted) return;
          showSnackBar(context, e.toString());
        }
      } else {
        showSnackBar(context, 'Silakan lengkapi data terlebih dahulu');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "IZIN"),
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
                        (prov.nign ?? user?.nign ?? '-').capitalize(),
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
                readOnly: widget.argument?.reason != null ? true : false,
                maxLines: 8,
                onChanged: (value) => _formKey.currentState!.validate(),
                validator: (value) {
                  if (value!.isEmpty) return 'Field ini harus diisi';
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: width(context),
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: (_imageReason == null)
                    ? InkWell(
                        onTap: () async {
                          final imageFile = await ImagePicker()
                              .pickImage(source: ImageSource.camera);

                          if (imageFile != null) {
                            setState(() => _imageReason = imageFile.path);
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 60,
                              color: black.withOpacity(.3),
                            ),
                            Text(
                              "Unggah Foto",
                              style: TextStyle(color: black.withOpacity(.3)),
                            ),
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.zero,
                              content: _image(),
                            ),
                          );
                        },
                        child: _image(),
                      ),
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

  Widget _image() {
    if (_imageReason!.contains('http')) {
      return BorderNetworkImage(
        url: _imageReason,
        fit: BoxFit.cover,
        margin: 0,
      );
    } else {
      return Image.file(
        File(_imageReason ?? ''),
        width: width(context),
        height: 150,
        fit: BoxFit.cover,
      );
    }
  }
}
