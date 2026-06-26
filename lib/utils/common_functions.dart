import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonFunc {
  static void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static Future<void> openUrl({required String url}) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  static String formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

}
