import 'package:eff_mob_tes_app/data/const.dart';
import 'package:flutter/material.dart';

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: const Color.fromARGB(255, 228, 238, 228),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 228, 238, 228),
    foregroundColor: Colors.black,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 228, 238, 228),
  ),

  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kDialogBorderRadius),
    ),
    surfaceTintColor: Colors.transparent,
    // backgroundColor: Color.fromARGB(255, 210, 212, 210),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color.fromARGB(255, 20, 20, 20)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 22, 22, 22)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 110, 104, 104)),
  ),
);

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kDialogBorderRadius),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color.fromARGB(255, 240, 237, 237)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 243, 241, 241)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 185, 192, 185)),
  ),
);
