import 'package:attendance/router/constants.dart';
import 'package:attendance/ui/pages/home/index.dart';
import 'package:attendance/ui/pages/login/index.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case rootRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );
      case homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );
      default:
        return null;
    }
  }
}
