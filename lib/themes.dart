import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static const String light = 'light';
  static const String dark = 'dark';
  static const String neon = 'neon';
  static const String retro = 'retro';
  static const String minimal = 'minimal';
  static const String gradient = 'gradient';
  static const String ocean = 'ocean';
  static const String sunset = 'sunset';
  static const String forest = 'forest';
  static const String cosmic = 'cosmic';

  static List<String> getThemeNames() {
    return [light, dark, neon, retro, minimal, gradient, ocean, sunset, forest, cosmic];
  }

  static ThemeData getTheme(String themeName) {
    switch (themeName) {
      case dark:
        return darkTheme;
      case neon:
        return neonTheme;
      case retro:
        return retroTheme;
      case minimal:
        return minimalTheme;
      case gradient:
        return gradientTheme;
      case ocean:
        return oceanTheme;
      case sunset:
        return sunsetTheme;
      case forest:
        return forestTheme;
      case cosmic:
        return cosmicTheme;
      case light:
      default:
        return lightTheme;
    }
  }

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 160,
        fontWeight: FontWeight.w300,
        shadows: [const Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
      ),
      bodyLarge: GoogleFonts.roboto(
        color: Colors.black54,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 160,
        fontWeight: FontWeight.w300,
        shadows: [const Shadow(color: Colors.white24, blurRadius: 4, offset: Offset(2, 2))],
      ),
      bodyLarge: GoogleFonts.roboto(
        color: Colors.white70,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData neonTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.greenAccent,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.orbitron(
        color: Colors.greenAccent,
        fontSize: 160,
        fontWeight: FontWeight.bold,
        shadows: [
          const Shadow(color: Colors.greenAccent, blurRadius: 20, offset: Offset(0, 0)),
          const Shadow(color: Colors.greenAccent, blurRadius: 40, offset: Offset(0, 0)),
        ],
      ),
      bodyLarge: GoogleFonts.orbitron(
        color: Colors.greenAccent,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData retroTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    scaffoldBackgroundColor: const Color(0xFFFFF8E1),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.pressStart2p(
        color: Colors.brown,
        fontSize: 100,
        fontWeight: FontWeight.w400,
        shadows: [const Shadow(color: Colors.brown, blurRadius: 2, offset: Offset(1, 1))],
      ),
      bodyLarge: GoogleFonts.pressStart2p(
        color: Colors.brown,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData minimalTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 180,
        fontWeight: FontWeight.w200,
      ),
      bodyLarge: GoogleFonts.inter(
        color: Colors.black38,
        fontSize: 28,
        fontWeight: FontWeight.w300,
      ),
    ),
  );

  static ThemeData gradientTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.purple,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 160,
        fontWeight: FontWeight.w500,
        shadows: [
          const Shadow(color: Colors.black45, blurRadius: 10, offset: Offset(3, 3)),
          const Shadow(color: Colors.black26, blurRadius: 20, offset: Offset(6, 6)),
        ],
      ),
      bodyLarge: GoogleFonts.roboto(
        color: Colors.white70,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData oceanTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 160,
        fontWeight: FontWeight.w500,
        shadows: [
          Shadow(color: const Color(0xFF0D47A1), blurRadius: 15, offset: const Offset(4, 4)),
        ],
      ),
      bodyLarge: GoogleFonts.roboto(
        color: Colors.white70,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData sunsetTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 160,
        fontWeight: FontWeight.w500,
        shadows: [
          Shadow(color: const Color(0xFFB71C1C), blurRadius: 15, offset: const Offset(4, 4)),
        ],
      ),
      bodyLarge: GoogleFonts.roboto(
        color: Colors.white70,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData forestTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 160,
        fontWeight: FontWeight.w500,
        shadows: [
          Shadow(color: const Color(0xFF1B5E20), blurRadius: 15, offset: const Offset(4, 4)),
        ],
      ),
      bodyLarge: GoogleFonts.roboto(
        color: Colors.white70,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData cosmicTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.orbitron(
        color: Colors.white,
        fontSize: 160,
        fontWeight: FontWeight.bold,
        shadows: [
          const Shadow(color: Colors.purpleAccent, blurRadius: 20, offset: Offset(0, 0)),
          const Shadow(color: Colors.blueAccent, blurRadius: 30, offset: Offset(0, 0)),
        ],
      ),
      bodyLarge: GoogleFonts.orbitron(
        color: Colors.white70,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}