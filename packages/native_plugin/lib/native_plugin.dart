
import 'dart:async';
import 'native_plugin_platform_interface.dart';

class NativePlugin {
  /// Method Channel Examples
  
  /// Get platform version
  Future<String?> getPlatformVersion() {
    return NativePluginPlatform.instance.getPlatformVersion();
  }
  
  /// Calculate sum of two numbers (Method Channel example)
  Future<int> calculateSum(int a, int b) {
    return NativePluginPlatform.instance.calculateSum(a, b);
  }
  
  /// Get device information (Method Channel example)
  Future<Map<String, dynamic>> getDeviceInfo() {
    return NativePluginPlatform.instance.getDeviceInfo();
  }
  
  /// Event Channel Examples
  
  /// Stream of random numbers (Event Channel example)
  Stream<int> getRandomNumberStream() {
    return NativePluginPlatform.instance.getRandomNumberStream();
  }
}
