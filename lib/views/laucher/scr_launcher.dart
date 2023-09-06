import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/utils/statusbar.dart';

class LaucherScreen extends StatefulWidget {
  const LaucherScreen({super.key});

  @override
  State<LaucherScreen> createState() => _LaucherScreenState();
}

class _LaucherScreenState extends State<LaucherScreen> {
  @override
  Widget build(BuildContext context) {
    uCustomStatusBar();
    return Scaffold(
      backgroundColor: MyColors.caribbeanGreenTint7,
      body: Expanded(child: Container(
        color: Colors.blue,
        
      )),
    );
  }
}
