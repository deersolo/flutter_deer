import 'package:deersolo/src/pages/home/widgets/chart.dart';
import 'package:deersolo/src/pages/home/widgets/custom_drawer.dart';
import 'package:deersolo/src/pages/home/widgets/custom_tabbar.dart';
import 'package:deersolo/src/pages/home/widgets/report.dart';
import 'package:deersolo/src/pages/home/widgets/stock.dart';
import 'package:deersolo/src/pages/login/widgets/header.dart';
import 'package:deersolo/src/pages/login/widgets/loginform.dart';
import 'package:deersolo/src/viewmodels/tab_menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:deersolo/src/pages/login/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _tabMenu = TabMenuViewModel().items;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: CustomDrawer(),
        body: TabBarView(
          children: _tabMenu.map((item) => item.widget).toList(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Stock Workshop'),
      bottom: CustomTabBar(_tabMenu),
      actions: [
        IconButton(
          icon: Icon(Icons.bookmark_border),
          onPressed: () {
            //todo
          },
        ),
      IconButton(
        icon: Icon(Icons.qr_code),
        onPressed: () {
          //todo
        },
      )
      ],
    );
  }

  TextButton _buildTextButton(String text, {
    required VoidCallback onPressed,
    double fontSize = 16,
  }) =>
      TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
}
