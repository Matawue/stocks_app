import 'package:flutter/material.dart';


class AppTheme {



  ThemeData getTheme() {
    const seedColor = Colors.deepPurpleAccent;

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor 
    );
  }

}