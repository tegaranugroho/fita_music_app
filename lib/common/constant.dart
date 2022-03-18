import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// colors
const Color primaryColor = Color.fromARGB(255, 81, 90, 102);
const Color secondaryColor = Color.fromARGB(255, 171, 214, 255);
const Color kMikadoYellow = Color(0xFFffc300);

// text style
final TextStyle kHeading5 =
    GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: Colors.white);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.15, color: Colors.white54);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.25);

// text theme
final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
);

const kColorScheme = ColorScheme(
  primary: kMikadoYellow,
  primaryContainer: kMikadoYellow,
  secondary: secondaryColor,
  secondaryContainer: secondaryColor,
  surface: primaryColor,
  background: primaryColor,
  error: Colors.red,
  onPrimary: primaryColor,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);
