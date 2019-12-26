import 'package:flutter/material.dart';
import 'package:marconi_radio/styles/colors.dart';
import 'package:marconi_radio/styles/text_style.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign alignment;
  final FontWeight fontWeight;
  final double fontSize;
  final int maxLines;

  BodyText(this.text, {
    this.color = appBlack,
    this.alignment = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 18.0,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, overflow: TextOverflow.ellipsis, maxLines: maxLines, textAlign: alignment, style: AppTextStyle.appText.copyWith(color: color, fontWeight: fontWeight, fontSize: fontSize),);
  }
}