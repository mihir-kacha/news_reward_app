part of '../core.dart';

extension DoubleExt on double? {


  String get toFormatted {
    if(this==null) return "0";
    int maxDecimal = 2;
    String value = this!.toStringAsFixed(maxDecimal);
    return value.replaceAll(RegExp(r'\.?0+$'), '');
  }
}
