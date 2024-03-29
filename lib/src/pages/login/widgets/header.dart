import 'package:deersolo/src/constants/asset.dart';
import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 1),
      child: Image.asset(
        Asset.LOGO_IMAGE,
        height: 220,
      ),
    );
  }
}