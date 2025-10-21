// lib/config/app_config.dart
class AppConfig {
  final String appName;
  final String apiBaseUrl;
  final String environment;
  final bool enableLogging;

  const AppConfig({
    required this.appName,
    required this.apiBaseUrl,
    required this.environment,
    required this.enableLogging,
  });

  factory AppConfig.fromEnvironment() {
    return AppConfig(
      appName: const String.fromEnvironment('APP_NAME', defaultValue: 'Flavors Demo'),
      apiBaseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'https://api.example.com'),
      environment: const String.fromEnvironment('ENVIRONMENT', defaultValue: 'unknown'),
      enableLogging: const bool.fromEnvironment('ENABLE_LOGGING', defaultValue: false),
    );
  }
}
