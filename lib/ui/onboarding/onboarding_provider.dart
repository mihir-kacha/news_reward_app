part of 'onboarding.dart';

final class OnboardingProvider extends BaseProvider{
  OnboardingProvider({required super.context});

  final PageController pageController = PageController();
  int currentIndex =0;

  void onNext() {
    if (currentIndex == 1) {
      context.navigator.pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false, arguments: false);
      preference.isShowOnBoarding = false;
    } else {
      currentIndex++;
      notifyListeners();
      pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }
}
