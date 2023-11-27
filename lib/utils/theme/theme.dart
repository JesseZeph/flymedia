import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontSize: 20.0, fontFamily: 'Karla'),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Karla',
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Karla',
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'Karla',
    ),
    displaySmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      fontFamily: 'Karla',
    ),
  ),
);
