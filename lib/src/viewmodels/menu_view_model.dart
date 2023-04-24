import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:deersolo/src/config/route.dart' as custom_route;

class Menu {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Function(BuildContext context) onTap;

  const Menu(this.title, {
    required this.onTap,
    required this.icon,
    required this.iconColor,
  });
}

class MenuViewModel {
  List<Menu> get items =>
      <Menu>[
        Menu(
          'Profile',
          icon: FontAwesomeIcons.users,
          iconColor: Colors.deepOrange,
          onTap: (context) {},
        ),
        Menu(
          'Dashboard',
          icon: FontAwesomeIcons.chartPie,
          iconColor: Colors.green,
          onTap: (BuildContext context) {
            Navigator.pushNamed(context, custom_route.Route.dashboard);
          },
        ),
        Menu(
          'Inbox',
          icon: FontAwesomeIcons.inbox,
          iconColor: Colors.amber,
          onTap: (BuildContext context) {},
        ),
        Menu(
          'Settings',
          icon: FontAwesomeIcons.cogs,
          iconColor: Colors.blueGrey,
          onTap: (BuildContext context) {},
        ),
      ];
}
