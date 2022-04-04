import 'dart:ffi';

import 'package:attendance/services/assets.dart';
import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAbsen = false;

  void clickAbsen() {
    setState(() {
      isAbsen = !isAbsen;
    });
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
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
                  style: mediumBlue20,
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        clickAbsen();
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
                      onPressed: () {},
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
                      "Marvin McKinney",
                      style: semiBold15,
                    ),
                    Text(
                      "319.555.0115",
                      style: semiBold10,
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
              color: isAbsen ? blue : grey,
              size: 150,
            ),
            SizedBox(
              height: 66,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: regular15,
                ),
                Text(
                  DateFormat.jm().format(DateTime.now()),
                  style: regular15,
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
                    style: medium15,
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
                    style: medium15,
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
                style: mediumBlue20,
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