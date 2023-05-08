import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.label,
      this.fontSize,
      this.color,
      this.fontWeight, this.textAlign})
      : super(key: key);

  final String label;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      // textAlign: TextAlign.justify,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
