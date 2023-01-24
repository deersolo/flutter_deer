
import 'package:flutter/cupertino.dart';

class Theme {
  const Theme();

  static const Color gradientStart = Color(0xFF29323C);
  static const Color gradientEnd = Color(0xFF2762A4);

  static const gradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1.0],
  );
}
