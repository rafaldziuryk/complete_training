// lib/config/config_prod.dart
import 'app_config.dart';

class ProdConfig implements AppConfig {
  @override
  String get appName => 'Flavors Demo - PROD';

  @override
  String get apiBaseUrl => 'https://api.example.com';

  @override
  String get environment => 'Production';

  @override
  bool get enableLogging => false;
}
