// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env/.env.dev')
abstract class DevEnv {
  @EnviedField(varName: 'APP_NAME')
  static const String appName = _DevEnv.appName;
  
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _DevEnv.apiBaseUrl;
  
  @EnviedField(varName: 'ENVIRONMENT')
  static const String environment = _DevEnv.environment;
  
  @EnviedField(varName: 'ENABLE_LOGGING')
  static const bool enableLogging = _DevEnv.enableLogging;
  
  @EnviedField(varName: 'ANALYTICS_ENABLED')
  static const String analyticsEnabled = _DevEnv.analyticsEnabled;
  
  @EnviedField(varName: 'CRASHLYTICS_ENABLED')
  static const String crashlyticsEnabled = _DevEnv.crashlyticsEnabled;
  
  @EnviedField(varName: 'DEBUG_MENU_ENABLED')
  static const String debugMenuEnabled = _DevEnv.debugMenuEnabled;
  
  @EnviedField(varName: 'FEATURE_FLAGS_ENABLED')
  static const String featureFlagsEnabled = _DevEnv.featureFlagsEnabled;
  
  @EnviedField(varName: 'VERSION')
  static const String version = _DevEnv.version;
  
  @EnviedField(varName: 'BUILD_NUMBER')
  static const int buildNumber = _DevEnv.buildNumber;
  
  // Native build fields
  @EnviedField(varName: 'ANDROID_APP_ID')
  static const String androidAppId = _DevEnv.androidAppId;
  
  @EnviedField(varName: 'ANDROID_APP_NAME')
  static const String androidAppName = _DevEnv.androidAppName;
  
  @EnviedField(varName: 'ANDROID_ICON_NAME')
  static const String androidIconName = _DevEnv.androidIconName;
  
  @EnviedField(varName: 'IOS_BUNDLE_ID')
  static const String iosBundleId = _DevEnv.iosBundleId;
  
  @EnviedField(varName: 'IOS_APP_NAME')
  static const String iosAppName = _DevEnv.iosAppName;
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
  
  @EnviedField(varName: 'ANALYTICS_ENABLED')
  static const String analyticsEnabled = _StagingEnv.analyticsEnabled;
  
  @EnviedField(varName: 'CRASHLYTICS_ENABLED')
  static const String crashlyticsEnabled = _StagingEnv.crashlyticsEnabled;
  
  @EnviedField(varName: 'DEBUG_MENU_ENABLED')
  static const String debugMenuEnabled = _StagingEnv.debugMenuEnabled;
  
  @EnviedField(varName: 'FEATURE_FLAGS_ENABLED')
  static const String featureFlagsEnabled = _StagingEnv.featureFlagsEnabled;
  
  @EnviedField(varName: 'VERSION')
  static const String version = _StagingEnv.version;
  
  @EnviedField(varName: 'BUILD_NUMBER')
  static const int buildNumber = _StagingEnv.buildNumber;
  
  // Native build fields
  @EnviedField(varName: 'ANDROID_APP_ID')
  static const String androidAppId = _StagingEnv.androidAppId;
  
  @EnviedField(varName: 'ANDROID_APP_NAME')
  static const String androidAppName = _StagingEnv.androidAppName;
  
  @EnviedField(varName: 'ANDROID_ICON_NAME')
  static const String androidIconName = _StagingEnv.androidIconName;
  
  @EnviedField(varName: 'IOS_BUNDLE_ID')
  static const String iosBundleId = _StagingEnv.iosBundleId;
  
  @EnviedField(varName: 'IOS_APP_NAME')
  static const String iosAppName = _StagingEnv.iosAppName;
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
  
  @EnviedField(varName: 'ANALYTICS_ENABLED')
  static const String analyticsEnabled = _ProdEnv.analyticsEnabled;
  
  @EnviedField(varName: 'CRASHLYTICS_ENABLED')
  static const String crashlyticsEnabled = _ProdEnv.crashlyticsEnabled;
  
  @EnviedField(varName: 'DEBUG_MENU_ENABLED')
  static const String debugMenuEnabled = _ProdEnv.debugMenuEnabled;
  
  @EnviedField(varName: 'FEATURE_FLAGS_ENABLED')
  static const String featureFlagsEnabled = _ProdEnv.featureFlagsEnabled;
  
  @EnviedField(varName: 'VERSION')
  static const String version = _ProdEnv.version;
  
  @EnviedField(varName: 'BUILD_NUMBER')
  static const int buildNumber = _ProdEnv.buildNumber;
  
  // Native build fields
  @EnviedField(varName: 'ANDROID_APP_ID')
  static const String androidAppId = _ProdEnv.androidAppId;
  
  @EnviedField(varName: 'ANDROID_APP_NAME')
  static const String androidAppName = _ProdEnv.androidAppName;
  
  @EnviedField(varName: 'ANDROID_ICON_NAME')
  static const String androidIconName = _ProdEnv.androidIconName;
  
  @EnviedField(varName: 'IOS_BUNDLE_ID')
  static const String iosBundleId = _ProdEnv.iosBundleId;
  
  @EnviedField(varName: 'IOS_APP_NAME')
  static const String iosAppName = _ProdEnv.iosAppName;
}
