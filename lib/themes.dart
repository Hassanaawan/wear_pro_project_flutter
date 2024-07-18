
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wear_pro/constants.dart';

class MyThemes {
  static final primary = Colors.blue;
  static final primaryColor = Colors.blue.shade300;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black87.withOpacity(0.3),
    primaryColorDark: primaryColor,
    // primaryTextTheme: darkTheme.textTheme,
    colorScheme: ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,

      textTheme: TextTheme(
        bodyText1: GoogleFonts.josefinSans(color: Colors.white)
      ),
      // primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(primary: primary,),
    dividerColor: Colors.black,
    textTheme: GoogleFonts.josefinSansTextTheme(),
    primarySwatch: kOrange,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
