part of '../core.dart';

extension DurationExt on int {
  Duration get milliseconds => Duration(milliseconds: this);

  Duration get seconds => Duration(seconds: this);

  String get twoDigit => toString().padLeft(2, '0');

  String get formattedIndian {
    return NumberFormat('#,##,##0', 'en_IN').format(this);
  }
}

extension PercentageExtension on num {
  int get percentage => round().clamp(0, 100);
}
