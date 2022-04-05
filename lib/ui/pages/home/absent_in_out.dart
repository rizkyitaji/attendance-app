import 'package:attendance/services/assets.dart';
import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsentInOut extends StatefulWidget {
  const AbsentInOut({Key? key}) : super(key: key);

  @override
  State<AbsentInOut> createState() => _AbsentInOutState();
}

class _AbsentInOutState extends State<AbsentInOut> {
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
                      style: poppinsBlackw600.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "319.555.0115",
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
              height: 45,
            ),
            Center(
              child: Text(
                "ABSEN MASUK",
                style: poppinsBlackw600.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 64,
            ),
            Icon(
              Icons.photo_camera_rounded,
              color: grey,
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
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "KIRIM",
                style: poppinsWhitew500.copyWith(
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                  140,
                  50,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
