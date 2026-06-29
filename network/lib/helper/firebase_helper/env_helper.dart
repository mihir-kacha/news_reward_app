
part of '../../network.dart';

class EnvHelper {
  EnvHelper._();

  static final EnvHelper instance = EnvHelper._();

  late final String _googleServerClientId;
  Future<void> initialize() async {
    await dotenv.load(fileName: ".env");

    _googleServerClientId= dotenv.env["GOOGLE_SERVER_CLIENT_ID"]??"";
    if ( _googleServerClientId.isEmpty) {
      throw Exception('missing environment variables');
    }
  }

  String get googleServerClientId=> _googleServerClientId;
}
