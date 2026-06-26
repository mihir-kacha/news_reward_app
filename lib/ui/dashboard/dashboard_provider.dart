part of 'dashboard.dart';

final class DashboardProvider extends BaseProvider {
  DashboardProvider({required super.context});

  int currentIndex = 0;

  void onSelectedTab(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      notifyListeners();
    }
  }
}
