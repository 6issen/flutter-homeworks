enum Environment { dev, prod }

class AppConfig {
  final String appName;
  final String baseUrl;
  final Environment environment;

  AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.environment,
  });

  static late AppConfig _instance;
  static AppConfig get instance => _instance;

  static void setConfig(AppConfig config) {
    _instance = config;
  }
}
