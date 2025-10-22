// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env/.env.dev')
abstract class DevEnv {
  @EnviedField(varName: 'APP_NAME', obfuscate: true)
  static final String appName = _DevEnv.appName;
  
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _DevEnv.apiBaseUrl;
  
  @EnviedField(varName: 'ENVIRONMENT')
  static const String environment = _DevEnv.environment;
  
  @EnviedField(varName: 'ENABLE_LOGGING')
  static const bool enableLogging = _DevEnv.enableLogging;
}

@Envied(path: '.env/.env.staging')
abstract class StagingEnv {
  @EnviedField(varName: 'APP_NAME')
  static const String appName = _StagingEnv.appName;
  
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _StagingEnv.apiBaseUrl;
  
  @EnviedField(varName: 'ENVIRONMENT')
  static const String environment = _StagingEnv.environment;
  
  @EnviedField(varName: 'ENABLE_LOGGING')
  static const bool enableLogging = _StagingEnv.enableLogging;
}

@Envied(path: '.env/.env.prod')
abstract class ProdEnv {
  @EnviedField(varName: 'APP_NAME')
  static const String appName = _ProdEnv.appName;
  
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _ProdEnv.apiBaseUrl;
  
  @EnviedField(varName: 'ENVIRONMENT')
  static const String environment = _ProdEnv.environment;
  
  @EnviedField(varName: 'ENABLE_LOGGING')
  static const bool enableLogging = _ProdEnv.enableLogging;
}
