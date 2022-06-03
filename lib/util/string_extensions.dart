extension DateFormatting on String {
  bool get isNumber => isEmpty || int.tryParse(this) != null;
}