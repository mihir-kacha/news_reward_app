part of 'routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  String get initRoute => SplashScreen.routeName;

  Route<dynamic>? onGeneratedRoute(RouteSettings settings) {
    debugPrint("Current Route :  ${settings.name}");
    CommonFunc.closeKeyboard();
    if (_authRoutes.containsKey(settings.name)) {
      return MaterialPageRoute(builder: _authRoutes[settings.name]!, settings: settings);
    }
    return mainRoute(settings);
  }

  Map<String, WidgetBuilder> get _authRoutes {
    return {};
  }

  Route<dynamic>? mainRoute(RouteSettings settings) {
    WidgetBuilder? builder;
    switch (settings.name) {
      case SplashScreen.routeName:
        builder = SplashScreen.builder;
        break;
      case DashboardScreen.routeName:
        builder = DashboardScreen.builder;
        break;
      case HomeScreen.routeName:
        builder = HomeScreen.builder;
        break;
      case CategoryScreen.routeName:
        builder = CategoryScreen.builder;
        break;
      case TaskScreen.routeName:
        builder = TaskScreen.builder;
        break;
      case RedeemScreen.routeName:
        builder = RedeemScreen.builder;
        break;
      case ProfileScreen.routeName:
        builder = ProfileScreen.builder;
        break;
      case ReferScreen.routeName:
        builder = ReferScreen.builder;
        break;
      case TipsScreen.routeName:
        builder = TipsScreen.builder;
        break;
      case LoginScreen.routeName:
        builder = LoginScreen.builder;
        break;
      case OnboardingScreen.routeName:
        builder = OnboardingScreen.builder;
        break;
      case NewsScreen.routeName:
        builder = NewsScreen.builder;
        break;
      case NewsDetailScreen.routeName:
        builder = NewsDetailScreen.builder;
        break;
      case NewsCodeScreen.routeName:
        builder = NewsCodeScreen.builder;
        break;
      case CongratulationScreen.routeName:
        builder = CongratulationScreen.builder;
        break;
      case HowItWorksScreen.routeName:
        builder = HowItWorksScreen.builder;
        break;
      case ReadNewsScreen.routeName:
        builder = ReadNewsScreen.builder;
        break;
      case VerifyScreen.routeName:
        builder = VerifyScreen.builder;
        break;
      default:
        return null;
    }
    return FadePageRoute(
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserProvider(
              context: context,
              userRepository: UserRepository(uid: Preference().userId ?? ""),
            ),
          ),
        ],
        child: builder!(context),
      ),
      settings: settings,
    );
  }
}
