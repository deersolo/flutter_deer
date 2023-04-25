import 'dart:ffi';

import 'package:deersolo/src/constants/setting.dart';
import 'package:deersolo/src/viewmodels/menu_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deersolo/src/config/route.dart' as custom_route;
import 'package:badges/badges.dart' as badges;

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    var a = [1,2,3,4];
    var b = [5,6,7,8];
    var c = [...b,...a];
    return Drawer(
        child: Column(children: [
          _buildProfile(),
          ..._buildMainMenu(),

          Spacer(),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.grey,
            ),
            title: TextButton(
              onPressed: () => showDialogLogout(context),
              child: Text('Logout'),

            ),
          ),
        ]));
  }

  void showDialogLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme
                    .of(dialogContext)
                    .textTheme
                    .labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove(Setting.TOKEN_PREF);
                  //prefs.clear();
                  Navigator.of(dialogContext).pop();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    custom_route.Route.login,
                        (route) => false,
                  );
                });
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme
                    .of(dialogContext)
                    .textTheme
                    .labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  UserAccountsDrawerHeader _buildProfile() =>
      UserAccountsDrawerHeader(
        accountName: Text('Deer Solo'),
        accountEmail: Text('deer@gtec.th'),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png'),
        ),
      );

  List<ListTile> _buildMainMenu() =>
      MenuViewModel()
          .items
          .map(
            (item) =>
            ListTile(
              title: Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
              leading: badges.Badge(
                showBadge: item.icon == FontAwesomeIcons.inbox,
                badgeContent: Text('99', style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                )),
                child: FaIcon(
                  item.icon,
                  color: item.iconColor,
                ),
              ),
              onTap: ()
              {
                item.onTap(context);
              }
            ),
        )
          .toList();
}
