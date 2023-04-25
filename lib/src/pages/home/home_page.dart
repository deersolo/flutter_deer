import 'package:deersolo/src/pages/home/widgets/custom_drawer.dart';
import 'package:deersolo/src/pages/login/widgets/header.dart';
import 'package:deersolo/src/pages/login/widgets/loginform.dart';
import 'package:flutter/material.dart';
import 'package:deersolo/src/pages/login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stock Workshop'),
        ),
        drawer: CustomDrawer(),
        body: TabBarView(
          children: [
            FlutterLogo(style: FlutterLogoStyle.horizontal),
            FlutterLogo(style: FlutterLogoStyle.stacked),
            FlutterLogo(),
          ],
        ),
      ),
    );
  }

  TextButton _buildTextButton(
    String text, {
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
