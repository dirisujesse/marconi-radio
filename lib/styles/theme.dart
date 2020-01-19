import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData appThemeData() {
  final base = ThemeData.light();
  return base.copyWith(
    brightness: Brightness.light,
    accentColor: black,
    primaryColor: white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    cardColor: Colors.white,
    textTheme: base.textTheme.apply(fontFamily: "OpenSans"),
    // primaryIconTheme: base.iconTheme.copyWith(
    //   size: 30,
    //   color: appGreen,
    // ),
    // tabBarTheme: base.tabBarTheme.copyWith(
    //   indicator: ShapeDecoration(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(5.0)
    //     )
    //   )
    // ),
    cursorColor: appGrey,
    indicatorColor: appGrey,
    iconTheme: base.iconTheme.copyWith(
      color: appGrey,
      size: 30,
    ),
  );
}
