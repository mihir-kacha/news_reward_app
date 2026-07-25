part of '../core.dart';

extension StringCasingExtension on String? {
  String capitalizeFirstLetter() {
    if ((this ?? "").isEmpty) return this ?? "";
    return this![0].toUpperCase() + this!.substring(1);
  }

  int toInt() {
    return this == null ? 0 : int.tryParse(this!) ?? 0;
  }
}

extension $IntExtension on int? {
  String get formatted {
    if (this == null) return "0";
    if (this! < 1000) return toString();

    final s = this!.abs().toString();
    final buffer = StringBuffer();

    final last3 = s.substring(s.length - 3);
    final rest = s.length > 3 ? s.substring(0, s.length - 3) : '';

    if (rest.isNotEmpty) {
      for (int i = 0; i < rest.length; i++) {
        if (i != 0 && (rest.length - i) % 2 == 0) buffer.write(',');
        buffer.write(rest[i]);
      }
      buffer.write(',');
    }

    buffer.write(last3);

    return this! < 0 ? '-${buffer.toString()}' : buffer.toString();
  }
}
