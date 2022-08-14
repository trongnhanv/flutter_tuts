extension AmountParsing on double {
  String toAmount({int fractionDigits = 2, String currency = "\$"}) {
    return currency + " " + toStringAsFixed(fractionDigits);
  }
}

extension DoubleParsing on String {
  double toDouble() {
    return double.tryParse(this) ?? 0;
  }
}
