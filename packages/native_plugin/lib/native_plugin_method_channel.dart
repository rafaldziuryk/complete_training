import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_plugin_platform_interface.dart';

/// An implementation of [NativePluginPlatform] that uses method channels and event channels.
class MethodChannelNativePlugin extends NativePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_plugin');
  
  /// Event channels for streaming data
  @visibleForTesting
  final randomNumberEventChannel = const EventChannel('native_plugin/random_numbers');

  /// Method Channel Implementations
  
  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
  
  @override
  Future<int> calculateSum(int a, int b) async {
    final result = await methodChannel.invokeMethod<int>('calculateSum', {
      'a': a,
      'b': b,
    });
    return result ?? 0;
  }
  
  @override
  Future<Map<String, dynamic>> getDeviceInfo() async {
    final result = await methodChannel.invokeMethod<Map<Object?, Object?>>('getDeviceInfo');
    return Map<String, dynamic>.from(result ?? {});
  }
  
  /// Event Channel Implementations
  
  @override
  Stream<int> getRandomNumberStream() {
    return randomNumberEventChannel.receiveBroadcastStream().map((event) {
      if (event is int) {
        return event;
      }
      return 0;
    });
  }
}
