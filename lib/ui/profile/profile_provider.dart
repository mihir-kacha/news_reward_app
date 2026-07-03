part of 'profile.dart';

final class ProfileProvider extends BaseProvider {
  final AuthRepository authRepository;
  final LoadingDialogHandler loadingDialogHandler;

  ProfileProvider({required super.context, required this.authRepository, required this.loadingDialogHandler});

  Future<void> onLogout() async {
    await processApi(
      request: () async {
        return await authRepository.logout();
      },
      onLoading: loadingDialogHandler.handleLoading,
    );
    if (context.mounted) {
      preference.clear();
      NavigationAdHelper.instance.navigate(
        onComplete: () {
          context.navigator.pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
        },
      );
    }
  }
}
