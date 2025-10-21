// lib/config/app_config.dart
abstract class AppConfig {
  String get appName;
  String get apiBaseUrl;
  String get environment;
  bool get enableLogging;
}
