
import 'package:deersolo/src/pages/pages.dart';
import 'package:flutter/cupertino.dart';

class Route {
  static const home = '/home';
  static const login = '/login';
  static const dashboard = '/dashboard';

  static Map<String, WidgetBuilder> getAll() => _route;

  static final Map<String, WidgetBuilder> _route = {
    home : (context) => HomePage(),
    login : (context) => LoginPage(),
    dashboard : (context) => DashBoardPage(),
  };
}

