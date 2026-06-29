import 'package:inshorts/core/core.dart';
import 'package:network/network.dart';

final class UserProvider extends BaseProvider with SubscriptionHelper {
  final UserRepository userRepository;

  UserProvider({required super.context, required this.userRepository});

  late UserModel userData = UserModel(
    id: preference.userId ?? '',
    name: preference.userInfo.name,
    email: preference.userInfo.email,
    coins: preference.userInfo.coins,
  );

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    subscriptions.addAll([userRepository.userInfoStream.listen(_onUserInfoUpdate)]);
    getUserInfo();
  }

  void _onUserInfoUpdate(UserModel? event) {
    if (event == null) return;
    userData = event;
    preference.userInfo = event.toGeneralInfo();
    notifyListeners();
  }

  Future<void> getUserInfo() async {
    final result = await processApi(
      request: () async {
        return await userRepository.getUserDetails();
      },
      onLoading: (loading) {
        isLoading = loading;
        notifyListeners();
      },
    );

    if (result != null) {
      userData = result;
      preference.userInfo = result.toGeneralInfo();
      notifyListeners();
    }
  }

  void addCoinsLocally(int coins) {
    final updated = userData.copyWith(coins: userData.coins! + coins);
    userData = updated;
    preference.userInfo = updated.toGeneralInfo();
    notifyListeners();
  }

  Future<void> refreshUser() async {
    await getUserInfo();
  }
}
