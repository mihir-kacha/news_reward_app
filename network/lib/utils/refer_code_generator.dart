part of '../network.dart';

class ReferCodeGenerator {
  static final Random _random = Random();
  static const String _letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  static String generate() {
    String numbers() => (_random.nextInt(90) + 10).toString();

    String letters() => String.fromCharCodes(
      List.generate(
        2,
            (_) => _letters.codeUnitAt(
          _random.nextInt(_letters.length),
        ),
      ),
    );

    return '${numbers()}${letters()}${numbers()}${letters()}';
  }
}