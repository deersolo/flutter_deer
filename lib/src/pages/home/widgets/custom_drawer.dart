
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(
        children: [
          TextButton(onPressed: onPressed, child: Text(text, style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.normal))),
        ],
      ),
    );
  }
}
