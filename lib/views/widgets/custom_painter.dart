 import 'package:flutter/material.dart';

import '../../utils/my_colors.dart';

class HeaderCurvedContainerForProfile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = MyColors.secondColor;
    Path path = Path()
      // ..relativeLineTo(0, 100)
      ..relativeLineTo(0, 200)
      // ..quadraticBezierTo(size.width / 2, 150, size.width, 50)
      ..quadraticBezierTo(size.width / 2, 300, size.width, 100)
      ..relativeLineTo(0, -100)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HeaderCurvedContainerForHome extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = MyColors.secondColor;
    Path path = Path()
      ..relativeLineTo(0, 50)
      ..quadraticBezierTo(
          size.width / 2,
          // bottom-center coltrol
          80,
          size.width,
          // bottom-right
          50)
      ..relativeLineTo(0, -50)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}