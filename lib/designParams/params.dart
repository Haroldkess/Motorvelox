import 'package:universal_io/io.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

double maxFactor = 1.5;
String appName = 'Findd';
double minFactor = 0.7;

Color defaultColor = Color(0xFF0D471);
Color background = Color(0xFF1E1E28);
Color darkCard = Color(0xFF191923);

double iconSizes = 15.0;

const double symmetricPadding = 5.0;
NumberFormat numberFormat = NumberFormat.decimalPattern();

double onlyAllPadding = 8.0;
currencySymbol() {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  return format.currencySymbol;
}
