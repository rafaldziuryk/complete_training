import 'dart:async';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_plugin_method_channel.dart';

abstract class NativePluginPlatform extends PlatformInterface {
  /// Constructs a NativePluginPlatform.
  NativePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativePluginPlatform _instance = MethodChannelNativePlugin();

  /// The default instance of [NativePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativePlugin].
  static NativePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativePluginPlatform] when
  /// they register themselves.
  static set instance(NativePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Method Channel Methods
  
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  
  Future<int> calculateSum(int a, int b) {
    throw UnimplementedError('calculateSum() has not been implemented.');
  }
  
  Future<Map<String, dynamic>> getDeviceInfo() {
    throw UnimplementedError('getDeviceInfo() has not been implemented.');
  }
  
  /// Event Channel Methods
  
  Stream<int> getRandomNumberStream() {
    throw UnimplementedError('getRandomNumberStream() has not been implemented.');
  }
}
