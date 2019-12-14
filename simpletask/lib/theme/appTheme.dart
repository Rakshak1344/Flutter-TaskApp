import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color _lightIconColor = Colors.redAccent;

  static Color _lightPrimaryColor = Colors.white;
  static Color _lightPrimaryVariantColor = Color(0XFFE1E1E1);
  static Color _lightSecondaryColor = Colors.red;
  static Color _lightOnPrimaryColor = Colors.black;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryVariantColor,
    appBarTheme: AppBarTheme(
      color: _lightPrimaryVariantColor,
      iconTheme: IconThemeData(color: _lightIconColor),
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),
    iconTheme: IconThemeData(color: _lightIconColor),
    textTheme: _lightTextTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      elevation: 10,
    ),
  );

  static final TextTheme _lightTextTheme = TextTheme(
    headline: _lightScreenHeadingTextStyle,
    body1: _lightScreenTaskNameTextStyle,
    body2: _lightScreenTaskDescTextStyle,
  );

  static final TextStyle _lightScreenHeadingTextStyle =
      TextStyle(fontSize: 48.0, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenTaskNameTextStyle =
      TextStyle(fontSize: 20.0, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenTaskDescTextStyle =
      TextStyle(fontSize: 16.0, color: Colors.grey);

  static Color _darkPrimaryVariantColor = Colors.black;
  static Color _darkPrimaryColor = Colors.white24;
  static Color _darkOnPrimaryColor = Colors.white;
  static Color _darkSecondaryColor = Colors.white;

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryVariantColor,
    appBarTheme: AppBarTheme(
      color: _darkPrimaryVariantColor,
      iconTheme: IconThemeData(color: _darkOnPrimaryColor),
    ),
    colorScheme: ColorScheme.light(
      primary: _darkPrimaryColor,
      primaryVariant: _darkPrimaryVariantColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
    ),
    iconTheme: IconThemeData(color: _darkOnPrimaryColor),
    textTheme: _darkTextTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.redAccent,
    ),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline: _darkScreenHeadingTextStyle,
    body1: _darkScreenTaskNameTextStyle,
    body2: _darkScreenTaskDescTextStyle,
  );

  static final TextStyle _darkScreenHeadingTextStyle =
      _lightScreenHeadingTextStyle.copyWith(color: _darkOnPrimaryColor);
  static final TextStyle _darkScreenTaskNameTextStyle =
      _lightScreenTaskNameTextStyle.copyWith(color: _darkOnPrimaryColor);
  static final TextStyle _darkScreenTaskDescTextStyle =
      _lightScreenTaskNameTextStyle.copyWith(color: _darkPrimaryColor);
}
