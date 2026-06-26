part of '../../network.dart';

abstract interface class ApiUrl {
  /// Prod
  static const String domain = 'https://newsdata.io';
  /// Dev
  static const String apiKey='pub_36897ab5c61242378c04b5594ef784b1'; // main
  // static const String apiKey='pub_eecdcccf234049f7ab1b1a2303786bb9'; // other
  static const String baseUrl = '$domain/api/1/latest';

  static const String refreshToken = '/auth/refresh-token';





}
