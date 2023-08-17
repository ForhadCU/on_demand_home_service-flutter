import 'package:flutter/material.dart';
import 'package:thesis_project/utils/constants.dart';
import 'package:thesis_project/utils/my_colors.dart';

import '../const/keywords.dart';

class BookingsViewModel {
  Color mGetServiceCatIconBgColor({required String categoryName}) {
    switch (categoryName) {
      case acRepair:
        return MyColors.acRepairBg;
      case paintings:
        return MyColors.paintingBg;
      case electronics:
        return MyColors.electronicsBg;
      case cleaning:
        return MyColors.electronicsBg;
      case beauty:
        return MyColors.beautyBg;

      case plumbing:
        return MyColors.plumbingBg;
      case shifting:
        return MyColors.shiftingBg;
      case barber:
        return MyColors.barbarBg;
      case tutor:
        return MyColors.tutorBg;
      default:
        return MyColors.caribbeanGreenTint3;
    }
  }
}
