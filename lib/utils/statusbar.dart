// ignore_for_file: unused_element, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_colors.dart';

/* class MyStatusBar {
  static void 
} */

uCustomStatusBar({Color? statusBarColor, Brightness? statusBarBrightness,
    Brightness? statusBarIconBrightness}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: statusBarColor ?? MyColors.caribbeanGreenTint7,
    statusBarBrightness: statusBarBrightness ?? Brightness.light,
    statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark,
  ));
}
