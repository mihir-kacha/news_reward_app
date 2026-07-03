part of 'onboarding.dart';

final class OnboardingProvider extends BaseProvider {
  OnboardingProvider({required super.context});

  final PageController pageController = PageController();
  int currentIndex = 0;

  void onPageChanged({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  void onNext() {
    if (currentIndex == 1) {
      preference.isShowOnBoarding = false;
      NavigationAdHelper.instance.navigate(
        onComplete: () {
          context.navigator.pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false, arguments: false);
        },
      );
    } else {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }
}
