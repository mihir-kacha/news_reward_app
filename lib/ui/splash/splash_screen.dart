part of 'splash.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashProvider(
        context: context,
        newsRepository: NewsRepository(),
        configRepository: ConfigRepository(),
        loadingDialogHandler: LoadingDialogHandler(context: context),
      ),
      child: SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SplashProvider>();
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: Assets.images.newsPaySplash.image(fit: BoxFit.cover)),
          Center(child: _LogoSection()),
          Positioned(bottom: Spacing.xxxLarge, left: Spacing.xLarge, right: Spacing.xLarge, child: _BottomLoader()),
        ],
      ),
    );
  }
}

class _LogoSection extends StatelessWidget {
  const _LogoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: Spacing.small,
      children: [
        ClipRRect(borderRadius: ShapeBorderRadius.large, child: Assets.images.newsPayLogo.image(height: 100)),
        Text(
          "NewsPay",
          style: context.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}

class _BottomLoader extends StatelessWidget {
  const _BottomLoader();

  @override
  Widget build(BuildContext context) {
    final isAdLoading = context.select<SplashProvider, bool>((p) => p.isAdLoading);
    if (!isAdLoading) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: context.padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: ShapeBorderRadius.xxLarge,
            child: SizedBox(
              width: 90,
              child: LinearProgressIndicator(
                minHeight: 2,
                backgroundColor: context.colorScheme.onPrimary.withColorOpacity(.25),
                valueColor: AlwaysStoppedAnimation(context.colorScheme.onPrimary),
              ),
            ),
          ),
          Gap(Spacing.small),
          Text(
            "This actions contains ads",
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onPrimary,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
