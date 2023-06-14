import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextAlign? textAlign;
  final String text;
  final Color? fontcolor;
  final double? fontsize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  const CustomText(
      {Key? key,
      required this.text,
      this.fontcolor,
      this.fontsize,
      this.fontWeight,
      this.textDecoration
      ,this.textAlign
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
    textAlign: textAlign,

        style: TextStyle(
            color: fontcolor,
            fontSize: fontsize,
            fontWeight: fontWeight,
            decoration: textDecoration));
  }
}