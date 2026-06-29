part of 'dashboard.dart';

final class DashboardProvider extends BaseProvider {
  DashboardProvider({required super.context});

  @override
  void initState() {
    super.initState();
    ConnectivityHelper.instance.updateContext(context);
  }

  int currentIndex = 0;

  void onSelectedTab(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      notifyListeners();
    }
  }
}
