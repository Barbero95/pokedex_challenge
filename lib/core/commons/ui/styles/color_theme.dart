import 'package:flutter/material.dart';

class CustomColors {
  static ColorScheme light(Color color) {
    return ColorScheme.fromSeed(
      seedColor: color,
    );
  }

  static ColorScheme dark(Color color) {
    return ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.dark,
    );
  }

  // Pokémon config
  static const Color red = Color(0xFFFF0000);
  static const Color bostonUniversityRed = Color(0xFFCC0000);
  static const Color ceruleanBlue = Color(0xFF3B4CCA);
  static const Color goldenYellow = Color(0xFFFFDE00);
  static const Color goldenFoil = Color(0xFFB3A125);

  // Pokémon Types
  static const Color normalPT = Color(0xFFAAB09F);
  static const Color firePT = Color(0xFFEA7A3C);
  static const Color waterPT = Color(0xFF539AE2);
  static const Color electricPT = Color(0xFFE5C531);
  static const Color grassPT = Color(0xFF71C558);
  static const Color psychicPT = Color(0xFFE5709B);
  static const Color fightingPT = Color(0xFFCB5F48);
  static const Color poisonPT = Color(0xFFB468B7);
  static const Color groundPT = Color(0xFFCC9F4F);
  static const Color flyingPT = Color(0xFF7DA6DE);
  static const Color dragonPT = Color(0xFF6A7BAF);
  static const Color bugPT = Color(0xFF94BC4A);
  static const Color rockPT = Color(0xFFB2A061);
  static const Color ghostPT = Color(0xFF846AB6);
  static const Color icePT = Color(0xFF70CBD4);
  static const Color steelPT = Color(0xFF89A1B0);
  static const Color darkPT = Color(0xFF736C75);
  static const Color fairyPT = Color(0xFFE397D1);

  // Generic colors
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color neutralBlack = Color(0xff222222);
  static const Color success = Colors.green;
  static const Color error = Colors.red;
}
