import 'package:attendance/ui/pages/login/index.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginPage(),
        );
      default:
        return null;
    }
  }
}
