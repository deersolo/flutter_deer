import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterLogo(
        size: 450,
        style: FlutterLogoStyle.horizontal,
      ),
    );
  }
}
