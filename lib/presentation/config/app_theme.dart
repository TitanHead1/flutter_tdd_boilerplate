import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "app_color.dart";

class AppTheme {
  ///<-----------------------------Light App Theme-------------------------------->

  ///light primary color
  static const int _bluePrimaryValue = 0xff3B82F6;

  ///convert app light color in MaterialColor for app theme
  static const MaterialColor primaryBlue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xff3B82F6),
      100: Color(0xff3B82F6),
      200: Color(0xff3B82F6),
      300: Color(0xff3B82F6),
      400: Color(0xff3B82F6),
      500: Color(0xff3B82F6),
      600: Color(0xff3B82F6),
      700: Color(0xff3B82F6),
      800: Color(0xff3B82F6),
      900: Color(0xff3B82F6),
    },
  );

  ///define light theme
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Roboto",
    primarySwatch: primaryBlue,
    primaryColor: const Color(0xffFFFFFF),
    useMaterial3: false,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: AppColor.appColor,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColor.appColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    sliderTheme: const SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
  );

  ///<-----------------------------Dark App Theme-------------------------------->

  ///dark primary color
  static const int _darkPrimary = 0xff474747;

  ///convert app light color in MaterialColor for app theme
  static const MaterialColor primaryDark = MaterialColor(
    _darkPrimary,
    <int, Color>{
      50: Color(0xff474747),
      100: Color(0xff474747),
      200: Color(0xff474747),
      300: Color(0xff474747),
      400: Color(0xff474747),
      500: Color(0xff474747),
      600: Color(0xff474747),
      700: Color(0xff474747),
      800: Color(0xff474747),
      900: Color(0xff474747),
    },
  );

  ///define dark theme
  static ThemeData darkTheme = ThemeData(
    fontFamily: "Roboto",
    primarySwatch: primaryBlue,
    primaryColor: Colors.black,
    useMaterial3: false,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      centerTitle: true,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );
}
