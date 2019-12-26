import 'package:marconi_radio/styles/colors.dart';
import 'package:flutter/material.dart';

const formInputStyle = InputDecoration();
const underlineInputStyle = InputDecoration(
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: appBlack, width: 2)
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: appBlack, width: 3)
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: appRed, width: 3)
  ),
);