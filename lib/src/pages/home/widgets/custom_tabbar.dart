import 'package:deersolo/src/viewmodels/tab_menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<TabMenu> tabsMenu;

  const CustomTabBar(this.tabsMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabsMenu
          .map(
            (item) => Tab(
                child: Row(
              children: [
                FaIcon(item.icon),
                SizedBox(width: 12),
                Text(item.title, style: TextStyle(
                  fontSize: 18, color: Colors.white
                ),)
              ],
            )),
          )
          .toList(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
