import 'package:deersolo/src/pages/login/widgets/header.dart';
import 'package:deersolo/src/pages/login/widgets/loginform.dart';
import 'package:flutter/material.dart';
import 'package:deersolo/src/pages/login/login_page.dart';

class Homepage extends StatelessWidget {
  // In the constructor, require a Todo.
  const Homepage({super.key, required this.name, required this.age});

  // Declare a field that holds the Todo.
  final String name;
  final int age;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      body: Column(
        children: [
          Header(),
          Text(name),
          Text(age.toString()),
          _buildTextButton('<< BACK', onPressed: () {
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
          }),
        ],
      ),
    );
  }

  TextButton _buildTextButton(String text, {
    required VoidCallback onPressed,
    double fontSize = 14,
  }) =>
      TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.green,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
}