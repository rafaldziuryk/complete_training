import 'package:flutter_test/flutter_test.dart';
import 'package:native_plugin/native_plugin.dart';

void main() {
  group('NativePlugin Tests', () {
    late NativePlugin plugin;

    setUp(() {
      plugin = NativePlugin();
    });

    group('Method Channel Tests', () {
      test('should get platform version', () async {
        final version = await plugin.getPlatformVersion();
        expect(version, isNotNull);
        expect(version, isA<String>());
      });

      test('should calculate sum correctly', () async {
        final result = await plugin.calculateSum(10, 20);
        expect(result, equals(30));
      });

      test('should get device info', () async {
        final deviceInfo = await plugin.getDeviceInfo();
        expect(deviceInfo, isA<Map<String, dynamic>>());
        expect(deviceInfo.isNotEmpty, isTrue);
      });
    });

    group('Event Channel Tests', () {
      test('should create random number stream', () {
        final stream = plugin.getRandomNumberStream();
        expect(stream, isA<Stream<int>>());
      });
    });
  });
}