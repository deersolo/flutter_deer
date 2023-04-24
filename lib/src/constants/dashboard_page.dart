import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DashBaord'),
        ),
        body: Center(
          child: FlutterLogo(
            size: 150,
          ),
        ));
  }
}
