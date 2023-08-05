
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyFormat {
  static mGenerate(BuildContext context) {
    Locale locale = Localizations.localeOf(context);

    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName);
    return format.currencySymbol;
  }
}
