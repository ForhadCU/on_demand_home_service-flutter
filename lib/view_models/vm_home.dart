import '../const/keywords.dart';

class HomeViewModel {
  String? mGetServiceCatIcon({required String serviceCategory}) {
    switch (serviceCategory) {
      case acRepair:
        return "assets/images/ic_ac_repair.png";
      case paintings:
        return "assets/images/ic_painting.png";
      case electronics:
        return "assets/images/ic_electronics.png";
      case cleaning:
        return "assets/images/ic_cleaning.png";
      case beauty:
        return "assets/images/ic_beauty.png";
      case plumbing:
        return "assets/images/ic_plumber.png";
      case shifting:
        return "assets/images/ic_shifting.png";
      case tutor:
        return "assets/images/ic_tutor.png";
      case barber:
        return "assets/images/ic_barabr.png";
      default:
        return null;
    }
  }
}
