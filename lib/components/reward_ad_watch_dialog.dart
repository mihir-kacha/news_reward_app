import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/components/model.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/generated/assets.gen.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:inshorts/utils/common_button.dart';

class RewardAdWatchDialog extends StatelessWidget {
  final int coins;

  const RewardAdWatchDialog({super.key, this.coins = 0});

  static Future<bool> show({required BuildContext context, int coins = 0}) async {
    return await showAppDialog<bool>(
      context: context,
      builder: (context) => RewardAdWatchDialog(coins: coins),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .all(Spacing.medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.imgCoin.image(height: 100),
          Gap(Spacing.small),
          Text(
            'Reward Available',
            textAlign: TextAlign.center,
            style: context.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: context.colorScheme.onSurface,
            ),
          ),
          Gap(Spacing.medium),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: 10),
              decoration: ShapeDecoration(
                shape: RoundedSuperellipseBorder(borderRadius: ShapeBorderRadius.normal),
                color: context.colorScheme.primary.withColorOpacity(.12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: Spacing.small,
                children: [
                  Container(
                    padding: .all(Spacing.small),
                    decoration: BoxDecoration(shape: .circle, color: context.colorScheme.primary),
                    child: Icon(Icons.assignment_rounded, color: context.colorScheme.onPrimary, size: 20),
                  ),
                  Flexible(
                    child: Text(
                      "Your reward is ready to be claimed.",
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(Spacing.normal),
          _DashedDivider(color: context.colorScheme.onSurface.withColorOpacity(.15)),
          Gap(Spacing.normal),
          Text(
            'Watch a short video ad to claim',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface.withColorOpacity(0.5)),
          ),
          Gap(Spacing.xSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: Spacing.xSmall,
            children: [
              Assets.icons.icCoins.svg(height: 22),
              Text(
                '$coins',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.primary,
                ),
              ),
              Text(
                'coins',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurface.withColorOpacity(.55),
                ),
              ),
            ],
          ),
          Gap(Spacing.xLarge),
          Row(
            spacing: Spacing.small,
            children: [
              Expanded(
                child: CommonButton.cupertino(
                  onTap: () => context.navigator.pop(false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Spacing.medium, horizontal: Spacing.small),
                    decoration: ShapeDecoration(
                      shape: RoundedSuperellipseBorder(
                        side: BorderSide(color: context.colorScheme.primary, width: 1.5),
                        borderRadius: ShapeBorderRadius.normal,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Not Now',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: CommonButton.cupertino(
                  onTap: () => context.navigator.pop(true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Spacing.medium, horizontal: Spacing.small),
                    decoration: ShapeDecoration(
                      shape: RoundedSuperellipseBorder(borderRadius: ShapeBorderRadius.normal),
                      color: context.colorScheme.primary,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.white.withColorOpacity(.25),
                            borderRadius: ShapeBorderRadius.small,
                          ),
                          child: Icon(Icons.play_arrow_rounded, color: context.colorScheme.onPrimary, size: 18),
                        ),
                        Gap(Spacing.small),
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              'Watch Ad & Claim',
                              style: context.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 1),
      painter: _DashedLinePainter(color: color),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) => oldDelegate.color != color;
}
