import 'package:attendance/providers/absent_provider.dart';
import 'package:attendance/providers/attendance_provider.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance/services/utils.dart';

class AbsentPage extends StatefulWidget {
  @override
  _AbsentPageState createState() => _AbsentPageState();
}

class _AbsentPageState extends State<AbsentPage> {
  final _cReason = TextEditingController();
  DateTime _currentDate = DateTime.now();

  void _send() async {
    final prov = Provider.of<AbsentProvider>(context, listen: false);
    try {
      final result = await prov.sendReason(
        context,
        prov.absent?.id ?? '-',
        _cReason.text.trim(),
      );
      showSnackBar(context, "Pesan sudah di kirim");
      Navigator.pop(context);
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "IZIN",
        showLogout: true,
      ),
      body: Consumer<UserProvider>(builder: (context, userProv, _) {
        final user = userProv.user;
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
                      (user?.name ?? '-').capitalize(),
                      style: poppinsBlackw600.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      (user?.id ?? '-').capitalize(),
                      style: poppinsBlackw600.copyWith(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, settingRoute),
                  child: Icon(Icons.settings),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "ALASAN TIDAK MASUK",
              style: poppinsBlackw400.copyWith(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _cReason,
              minLines: 8,
              maxLines: null,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _currentDate.formatMMMMddy(),
                  style: poppinsBlackw400.copyWith(
                    fontSize: 15,
                  ),
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
            ElevatedButton(
              onPressed: () {
                _send();
              },
              child: Text("KIRIM"),
            ),
          ],
        );
      }),
    );
  }
}
