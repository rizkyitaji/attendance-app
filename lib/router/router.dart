import 'package:attendance/models/absent.dart';
import 'package:attendance/models/user.dart';
import 'package:attendance/router/constants.dart';
import 'package:flutter/material.dart';

import '../ui/pages/attendance/absent.dart';
import '../ui/pages/attendance/index.dart';
import '../ui/pages/home/index.dart';
import '../ui/pages/login/index.dart';
import '../ui/pages/profile/index.dart';
import '../ui/pages/root/index.dart';
import '../ui/pages/setting/index.dart';

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case rootRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RootPage(),
        );
      case loginRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginPage(),
        );
      case homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );
      case attendanceRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AttendancePage(
            argument: settings.arguments as User,
          ),
        );
      case absentRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AbsentPage(
            argument: settings.arguments as Absent,
          ),
        );
      case profileRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProfilePage(
            argument: settings.arguments as User,
          ),
        );
      case settingRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SettingPage(),
        );
      default:
        return null;
    }
  }
}
