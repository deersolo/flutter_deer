import 'package:deersolo/src/login/widgets/header.dart';
import 'package:deersolo/src/login/widgets/loginform.dart';
import 'package:deersolo/src/login/widgets/single_sign_on.dart';
import 'package:flutter/foundation.dart';
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
                BoxDecoration(gradient: custom_theme.Theme.gradient),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                LoginForm(),
                SizedBox(height: 8),
                _buildTextButton('Forgot Password?', onPressed: () {  }),
                SizedBox(height: 12),
                SingleSignOn(),
                SizedBox(height: 8),
                _buildTextButton('Do not an Account', onPressed: () {  }),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextButton _buildTextButton(
      String text, {
        required VoidCallback onPressed,
        double fontSize = 14,
      }) =>
      TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
           color: Colors.white,
           fontSize: fontSize,
           fontWeight: FontWeight.normal,
          ),
        ),
      );
}