import 'package:access_control/theme/colors.dart';
import 'package:access_control/theme/text_theme/text_theme.dart';
import 'package:flutter/material.dart';

class AccAppTheme {
  AccAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightGrey,
    primaryColor: primaryColor,
    focusColor: lightGrey,
    fontFamily: 'roboto',
    textTheme: AccTextTheme.lightTextTheme,
    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color.fromARGB(1, 31, 154, 30),
    focusColor: lightGrey,
    fontFamily: 'roboto',
    textTheme: AccTextTheme.darkTextTheme,
    useMaterial3: true,
  );
}
