import 'package:intl/intl.dart';

class MyDateForamt {
  //c: day/month/year
  static mFormateDate(DateTime d) {
    return DateFormat('dd/MM/yyyy').format(d);
  }

  //c: month day, year
  static mFormateDate2(DateTime d) {
    return DateFormat('yMMMMd').format(d);
  }

  //c: year-month-day
  static mFormateDateDB(DateTime d) {
    return DateFormat('yyyy-MM-dd').format(d);
  }
}
