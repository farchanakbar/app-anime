import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const colorSatu = Color(0xFF2C3333);
const colorDua = Color(0xFF395B64);
const colorTiga = Color(0xFFA5C9CA);
const colorEmpat = Color(0xFFE7F6F2);

class CustomTheme {
  static const lightThemeFont = "ComicNeue", darkThemeFont = "Poppins";

  // light theme
  static final lightTheme = ThemeData(
    primaryColor: lightThemeColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: white,
    useMaterial3: true,
    fontFamily: lightThemeFont,
    switchTheme: SwitchThemeData(
      thumbColor:
          MaterialStateProperty.resolveWith<Color>((states) => lightThemeColor),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: white,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: black,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: lightThemeColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: lightThemeColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );

  // dark theme
  static final darkTheme = ThemeData(
    primaryColor: colorSatu,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colorSatu,
    useMaterial3: true,
    fontFamily: darkThemeFont,
    switchTheme: SwitchThemeData(
      trackColor:
          MaterialStateProperty.resolveWith<Color>((states) => colorSatu),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: colorSatu,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: white,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: white),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: colorSatu,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );

  // colors
  static Color lightThemeColor = Colors.red,
      white = Colors.white,
      black = Colors.black,
      darkThemeColor = Colors.yellow;
}
