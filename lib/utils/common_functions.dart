import 'package:flutter/material.dart';
import 'package:inshorts/utils/app_constant.dart';
import 'package:share_plus/share_plus.dart';
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

  static void inviteFriends({required String referralCode}) {
    SharePlus.instance.share(
      ShareParams(
        title: "Join NewsPay – Earn Coins by Doing Simple Tasks! 🪙",
        text:
            """🤑 Want to earn coins just by completing simple tasks & read news?

Meet NewsPay the app that rewards you for your time:
✅ Complete easy tasks & read news
✅ Earn coins with every code submission
✅ Withdraw your rewards anytime
✅ 100% free to join & use

💰 Join NewsPay and start earning today!

🎁 Use my referral code: *$referralCode*
👇 Download now:
${AppConstants.playStoreUrl}

— Turn your spare time into real rewards 🪙""",
      ),
    );
  }
}
