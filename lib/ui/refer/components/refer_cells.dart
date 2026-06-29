part of '../refer.dart';

class _DataCell extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final String info;
  final Color color;

  const _DataCell({
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Spacing.small, horizontal: Spacing.medium),
      decoration: BoxDecoration(
        color: color.withColorOpacity(.08),
        borderRadius: ShapeBorderRadius.medium,
        border: Border.all(color: color.withColorOpacity(.1)),
        // boxShadow: [
        //   BoxShadow(color: context.colorScheme.shadow.withColorOpacity(.1), blurRadius: 4, offset: Offset(0, 0)),
        // ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.normal),
            decoration: BoxDecoration(color: color.withColorOpacity(.1), shape: BoxShape.circle),
            child: SvgPicture.asset(icon, width: 24, height: 24, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
          ),
          Gap(Spacing.medium),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.shadow,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subTitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.shadow,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  info,
                  style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.surfaceTint),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferCodeCell extends StatelessWidget {
  const _ReferCodeCell();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Spacing.normal),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withColorOpacity(.03),
        borderRadius: ShapeBorderRadius.medium,
        border: Border.all(color: context.colorScheme.primary.withColorOpacity(.1)),
        // boxShadow: [
        //   BoxShadow(color: context.colorScheme.shadow.withColorOpacity(.1), blurRadius: 4, offset: Offset(0, 0)),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.icons.icGift.svg(
                height: 20,
                colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
              ),
              Gap(Spacing.small),
              RichText(
                text: TextSpan(
                  text: "Earn ",
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.shadow,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: "50 points ",
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: "per friend refer",
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.shadow,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(Spacing.medium),
          DashedBorderContainer(
            padding: EdgeInsetsGeometry.zero,
            dashColor: context.colorScheme.primary.withColorOpacity(.1),
            borderRadius: Spacing.medium,
            child: Container(
              padding: EdgeInsets.all(Spacing.medium),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withColorOpacity(.05),
                borderRadius: ShapeBorderRadius.medium,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${Preference().referCode}",
                    style: context.textTheme.headlineSmall?.copyWith(color: context.colorScheme.secondary),
                  ),
                  CommonButton.cupertino(
                    onTap: () {
                      HapticFeedback.vibrate();
                      Clipboard.setData(ClipboardData(text: "${Preference().referCode}"));
                    },
                    child: Icon(Icons.copy, color: context.colorScheme.shadow),
                  ),
                ],
              ),
            ),
          ),

          Gap(Spacing.xSmall),
          Text(
            "Your Invite Code",
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.surfaceTint,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferCells extends StatelessWidget {
  const _ReferCells();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ReferProvider>();
    final referCode = Preference().referCode;
    return Form(
      key: provider.formKey,
      child: Container(
        padding: EdgeInsets.all(Spacing.normal),
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary,
          borderRadius: ShapeBorderRadius.medium,
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Assets.icons.icAddFriend.svg(
                  height: 20,
                  colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
                ),
                Gap(Spacing.small),
                Expanded(
                  child: Text(
                    "Add Friend Code",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.shadow,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Gap(Spacing.medium),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: AppInputField(
                    maxLength: 8,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        return newValue.copyWith(text: newValue.text.toUpperCase(), selection: newValue.selection);
                      }),
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                      LengthLimitingTextInputFormatter(8),
                    ],
                    controller: provider.codeController,
                    borderRadius: Spacing.medium,
                    fillColor: context.colorScheme.secondary.withColorOpacity(.1),
                    filled: true,
                    borderColor: context.colorScheme.primary.withColorOpacity(.1),
                    validator: (value) {
                      final code = value?.trim() ?? "";
                      if (code.isEmpty) {
                        return "Please enter referral code";
                      }
                      if (code == referCode) {
                        return "Can't use your own referral code";
                      }
                      if (!RegExp(r'^[A-Z0-9]{8}$').hasMatch(code)) {
                        return "Referral code must be 8 uppercase letters/numbers";
                      }

                      return null;
                    },
                  ),
                ),
                Gap(Spacing.medium),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: provider.onContinue,
                    child: Text(
                      "Apply",
                      style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReferCompletedCell extends StatelessWidget {
  const _ReferCompletedCell();

  @override
  Widget build(BuildContext context) {
    final referCode = context.select<ReferProvider, String?>((value) => value.inviterReferralCode);
    return Container(
      width: context.width,
      padding: EdgeInsets.all(Spacing.normal),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withColorOpacity(.1),
        borderRadius: ShapeBorderRadius.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Referral Code applied!",
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(Spacing.xSmall),
          Text(
            "Referred by : $referCode",
            style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
