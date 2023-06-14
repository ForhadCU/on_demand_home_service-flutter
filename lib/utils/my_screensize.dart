import 'package:flutter/cupertino.dart';

class MyScreenSize {
  static mGetHeight(BuildContext context, double percentage) {
    return (MediaQuery.of(context).size.height * percentage) / 100;
  } static mGetWidth(BuildContext context, double percentage) {
    return (MediaQuery.of(context).size.width * percentage) / 100;
  }
}