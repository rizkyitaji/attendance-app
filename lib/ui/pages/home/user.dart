import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/ui/pages/home/widgets/attend_option.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_appbar.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  DateTime _currentDate = DateTime.now();
  bool _isAttend = false;

  void _showModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AttendOptionModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showLogout: true),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<UserProvider>(
                builder: (context, value, _) {
                  final user = value.user;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? '-'.toUpperCase(),
                        style: poppinsBlackw600.copyWith(fontSize: 16),
                      ),
                      Text(
                        user?.id ?? '-',
                        style: poppinsBlackw600.copyWith(fontSize: 12),
                      ),
                    ],
                  );
                },
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.settings),
              )
            ],
          ),
          SizedBox(height: 80),
          Icon(
            Icons.check_circle_outline_rounded,
            color: _isAttend ? blue : grey,
            size: 150,
          ),
          SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMMd().format(_currentDate),
                style: poppinsBlackw400.copyWith(fontSize: 15),
              ),
              Text(
                DateFormat.jm().format(_currentDate),
                style: poppinsBlackw400.copyWith(fontSize: 15),
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("IZIN"),
                ),
              ),
              SizedBox(width: 32),
              Expanded(
                child: ElevatedButton(
                  onPressed: _showModal,
                  child: Text("ABSEN"),
                ),
              )
            ],
          ),
          SizedBox(height: 40),
          OutlinedButton(
            onPressed: () {},
            child: Text("DAFTAR ABSEN"),
          ),
        ],
      ),
    );
  }
}
