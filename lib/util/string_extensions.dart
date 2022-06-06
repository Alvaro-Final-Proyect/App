import 'dart:math';

extension DateFormatting on String {
  bool get isNumber => isEmpty || int.tryParse(this) != null;
}

extension Round on double {
  double roundToPrecision(int n) {
    num fac = pow(10, n);
    return (this * fac).round() / fac;
  }
}