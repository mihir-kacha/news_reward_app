part of '../core.dart';

abstract base class BaseProvider extends ChangeNotifier {
  final BuildContext context;
  Preference preference = Preference();

  BaseProvider({required this.context}) {
    initState();
  }

  void initState() {}

  Future<T?> processApi<T>({required Future<T?> Function() request, void Function(bool loading)? onLoading}) async {
    onLoading?.call(true);

    if (!await checkInternet()) {
      if (context.mounted) {
        context.showErrorMessage(title: "Internet not connected");
        onLoading?.call(false);
        return Future.value(null);
      }
    }
    final result = await request().onError(handleException);
    if (context.mounted) {
      onLoading?.call(false);
      return result;
    }
    return null;
  }

  FutureOr<T?> handleException<T>(Object error, StackTrace stackTrace) {
    if (!context.mounted) {
      return null;
    }
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());

    switch (error) {
      // case UnAuthenticated():
      //   preference.clear();
      //   context.showErrorMessage(title: "User session expired!");
      //   break;

      case TimeoutException():
        context.showErrorMessage(title: "Timeout!", content: "Please check your internet connectivity and try again.");
        break;

      case PlatformException():
        if (error.code == "firebase_firestore") {
          final errorCode = error.details["code"];
          switch (errorCode) {
            case "unavailable":
              context.showErrorMessage(
                title: "Internet connection error!",
                content: "Please check your internet connectivity and try again.",
              );
              break;
          }
        }
        break;
      case HttpException():
      case SocketException():
        context.showErrorMessage(
          title: "Internet connection error!",
          content: "Please check your internet connectivity and try again.",
        );
        break;
      //
      case DefaultException():
        context.showErrorMessage(title: error.message, content: null);
        break;

      default:
        context.showErrorMessage(
          title: "Something went wrong!",
          content: "An unknown error has been occurred. Please try after sometime.",
        );
    }
    return null;
  }

  Future<bool> checkInternet() async {
    List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet) ||
        connectivityResult.contains(ConnectivityResult.ethernet) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }
}
