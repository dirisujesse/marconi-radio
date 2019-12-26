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
    indicatorColor: Colors.black,
    iconTheme: base.iconTheme.copyWith(
      color: appGrey,
      size: 30,
    ),
  );
}
