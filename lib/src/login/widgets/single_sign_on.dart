
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleSignOn extends StatelessWidget {
  const SingleSignOn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider()
      ],
    );
  }

  Row _buildDivider() {
    final gradientColor = const [Colors.white10, Colors.white];
    final line = (List<Color> colors) => Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin:  Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
        ),
      ),
      width: 80.0,
      height: 1.0,
    );

    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        line(gradientColor),
        const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15),
          child: Text ('or', style: TextStyle(
            color: Colors.white60,
            fontSize: 16.0,
          ),
          ),
        ),
        line(gradientColor.reversed.toList())
    ]
  );
  }
}
