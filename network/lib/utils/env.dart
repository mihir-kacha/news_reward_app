part of '../network.dart';

class Env {
  Env._();

  static final Env _instance = Env._();

  factory Env() => _instance;
  late Environment environment;

  bool get isDeviceMode => environment == Environment.dev;

  void setEnvironment(Environment env) {
    environment = env;
  }
}
