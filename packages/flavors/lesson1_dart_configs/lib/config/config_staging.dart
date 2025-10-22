// lib/config/config_staging.dart
import 'app_config.dart';

class StagingConfig implements AppConfig {
  @override
  String get appName => 'Flavors Demo - STAGING';

  @override
  String get apiBaseUrl => 'https://api-staging.example.com';

  @override
  String get environment => 'Staging';

  @override
  bool get enableLogging => true;
}
