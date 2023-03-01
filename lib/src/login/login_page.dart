import 'package:deersolo/src/login/widgets/header.dart';
import 'package:deersolo/src/login/widgets/loginform.dart';
import 'package:deersolo/src/login/widgets/single_sign_on.dart';
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
              Text('data'),
              SingleSignOn(),
              Text('data2'),

            ],
          ),
        ],
      ),
    );
  }
}
