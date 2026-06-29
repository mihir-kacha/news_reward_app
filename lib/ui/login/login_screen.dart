part of 'login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(
        context: context,
        configRepository: ConfigRepository(),
        loadingHandler: LoadingDialogHandler(context: context),
        authRepository: AuthRepository(),
      ),
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return Scaffold(
      backgroundColor: context.colorScheme.onPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Spacing.normal),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "NewsPay: ",
                  style: context.textTheme.headlineSmall,
                  children: [
                    TextSpan(
                      text: "Read To Earn Money",
                      style: context.textTheme.headlineSmall?.copyWith(color: context.colorScheme.primary),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Welcome to InShorts - Stay Updated with News \nand earn Daily Rewards",
                style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.surfaceTint),
                textAlign: TextAlign.center,
              ),
              Stack(
                children: [
                  Assets.images.imgLogin.image(height: context.height/1.8),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: context.width,
                      padding: EdgeInsets.all(Spacing.medium),
                      decoration: BoxDecoration(
                        color: context.colorScheme.onPrimary,
                        borderRadius: ShapeBorderRadius.large,
                        boxShadow: [
                          BoxShadow(
                            color: context.colorScheme.primary.withColorOpacity(.2),
                            offset: Offset(0, 4),
                            spreadRadius: 10,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Assets.images.imgGiftWithCoins.image(height: 100),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Read News. ",
                                    style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                        text: "Earn Rewards",
                                        style: context.textTheme.bodyLarge?.copyWith(
                                          color: context.colorScheme.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Gap.expand(Spacing.small),
                                Row(
                                  children: [
                                    _IconCell(
                                      icon: Assets.icons.icNews.path,
                                      title: "Read News",
                                      color: context.colorScheme.primary,
                                    ),
                                    _IconCell(
                                      icon: Assets.icons.icCoins.path,
                                      title: "Earn Coins",
                                      color: Color(0xFFfbc51f),
                                    ),
                                    _IconCell(
                                      icon: Assets.icons.icGift.path,
                                      title: "Redeem Gifts",
                                      color: Color(0xFFfd5862),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(Spacing.normal),
              CommonButton.cupertino(
                onTap: () {
                  provider.onGoogleSignIn();
                },
                child: Container(
                  width: context.width,
                  padding: EdgeInsets.symmetric(vertical: Spacing.small),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: ShapeBorderRadius.xxxLarge,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(Spacing.small),
                        decoration: BoxDecoration(color: context.colorScheme.onPrimary, shape: BoxShape.circle),
                        child: Assets.images.imgGoogle.image(height: 24),
                      ),
                      Gap(Spacing.normal),
                      Text(
                        "Continue with Google",
                        style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(Spacing.normal),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.surfaceTint,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(text: "By Continue, you agree ton our\n"),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          CommonFunc.openUrl(url: AppConstants.privacyPolicyUrl);
                        },
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Terms of Service",
                      style: TextStyle(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          CommonFunc.openUrl(url: AppConstants.termsAndConditions);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconCell extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;

  const _IconCell({required this.icon, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(color: color.withColorOpacity(.08), shape: BoxShape.circle),
            child: SvgPicture.asset(icon, height: 18, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
          ),
          Gap(Spacing.xSmall),
          Text(
            title,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.shadow,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
