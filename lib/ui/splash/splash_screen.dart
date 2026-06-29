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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "NewsPay",
              style: context.textTheme.headlineLarge?.copyWith(color: context.colorScheme.onPrimary),
            ),
          ),
          // Gap(Spacing.xxxLarge),
          // FilledButton(onPressed: provider.changeScreen, child: Text("Get API Data")),
        ],
      ),
    );
  }
}
