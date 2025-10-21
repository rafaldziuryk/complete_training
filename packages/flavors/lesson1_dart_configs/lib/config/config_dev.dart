// lib/config/config_dev.dart
import 'app_config.dart';

class DevConfig implements AppConfig {
  @override
  String get appName => 'Flavors Demo - DEV';

  @override
  String get apiBaseUrl => 'https://api-dev.example.com';

  @override
  String get environment => 'Development';

  @override
  bool get enableLogging => true;
}
