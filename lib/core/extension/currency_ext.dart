part of '../core.dart';

extension CoinConverter on int {
  double toCurrency() {
    return this / Preference().coins;
  }
}
