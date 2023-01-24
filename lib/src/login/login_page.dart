import 'package:deersolo/src/login/widgets/header.dart';
import 'package:deersolo/src/login/widgets/loginform.dart';
import 'package:flutter/material.dart';
import 'package:deersolo/config/theme.dart' as custom_theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration:
                const BoxDecoration(gradient: custom_theme.Theme.gradient),
          ),
          Column(
            children: const [
              Header(),
              LoginForm(),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.camera),
                onPressed: null, // null disables the button
              ),
              IconButton(
                icon: Icon(Icons.gamepad),
                color: Colors.yellow,
                onPressed: null,
              ),
              IconButton(
                icon: Icon(Icons.menu),
                color: Colors.yellow,
                onPressed: null,
              ),
              Text('Hello World'),
              Text('DEER3'),
              Text('DEER4'),
              Text('DEER5'),
            ],
          ),
        ],
      ),
    );
  }
}
