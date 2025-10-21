// lib/config/app_config.dart
import '../env/env.dart';

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
    // Sprawdź które środowisko jest aktywne
    const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
    
    switch (environment) {
      case 'dev':
        return AppConfig(
          appName: DevEnv.appName,
          apiBaseUrl: DevEnv.apiBaseUrl,
          environment: DevEnv.environment,
          enableLogging: DevEnv.enableLogging,
        );
      case 'staging':
        return AppConfig(
          appName: StagingEnv.appName,
          apiBaseUrl: StagingEnv.apiBaseUrl,
          environment: StagingEnv.environment,
          enableLogging: StagingEnv.enableLogging,
        );
      case 'prod':
        return AppConfig(
          appName: ProdEnv.appName,
          apiBaseUrl: ProdEnv.apiBaseUrl,
          environment: ProdEnv.environment,
          enableLogging: ProdEnv.enableLogging,
        );
      default:
        throw Exception('Unknown environment: $environment');
    }
  }
}
