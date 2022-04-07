import 'dart:ffi';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/firebase.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/assets.dart';
import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();

  bool _isAbsen = false;

  void _clickAbsen() {
    setState(() {
      _isAbsen = !_isAbsen;
    });
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          final prov = Provider.of<UserProvider>(context);
          return Container(
            padding: EdgeInsets.only(
              left: 35,
              top: 25,
              right: 35,
            ),
            height: 270,
            color: white,
            child: Column(
              children: [
                Text(
                  "PILIH ABSEN",
                  style: poppinsBluew500,
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final name = prov.user?.name;
                        final nign = prov.user?.id;
                        final XFile photo = await _picker.pickImage(
                            source: ImageSource.camera) as XFile;
                        FirebaseService.uploadImage(
                            photo, (name! + "_" + nign!));
                      },
                      child: Text("MASUK"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          140,
                          50,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        XFile photo = await _picker.pickImage(
                            source: ImageSource.camera) as XFile;
                        FirebaseService.uploadImage(photo, "Cobadulu2");
                      },
                      child: Text("PULANG"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          140,
                          50,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("KELUAR"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
        iconLogo,
        width: 60,
      )),
      body: Padding(
        padding: const EdgeInsets.only(left: 35, top: 25, right: 35),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${prov.user?.name}".toUpperCase(),
                      style: poppinsBlackw600.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${prov.user?.id}",
                      style: poppinsBlackw600.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.settings)
              ],
            ),
            SizedBox(
              height: 108,
            ),
            Icon(
              Icons.check_circle_outline_rounded,
              color: _isAbsen ? blue : grey,
              size: 150,
            ),
            SizedBox(
              height: 66,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMMd().format(
                    DateTime.now(),
                  ),
                  style: poppinsBlackw400.copyWith(
                    fontSize: 15,
                  ),
                ),
                Text(
                  DateFormat.jm().format(DateTime.now()),
                  style: poppinsBlackw400.copyWith(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 53,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "IZIN",
                    style: poppinsWhitew500.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      140,
                      50,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showModal();
                  },
                  child: Text(
                    "ABSEN",
                    style: poppinsWhitew500.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      140,
                      50,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 32,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text(
                "DAFTAR ABSEN",
                style: poppinsBluew500.copyWith(
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                  290,
                  71,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// nambahin comment coba