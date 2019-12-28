import 'package:flutter/material.dart';
import 'package:marconi_radio/styles/colors.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign alignment;
  final FontWeight fontWeight;
  final double fontSize;
  final int maxLines;

  HeaderText(
    this.text, {
    this.color = appBlack,
    this.alignment = TextAlign.start,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 25.0,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: alignment,
      style: Theme.of(context).textTheme.headline.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: 'Italiana'),
    );
  }
}
