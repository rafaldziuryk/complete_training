import 'package:test/test.dart';
import 'package:future_streams/future_streams.dart';

void main() {
  group('Future Examples', () {
    test('fetchData should return data after delay', () async {
      final result = await fetchData('test-endpoint');
      expect(result, equals('Dane z test-endpoint'));
    });

    test('riskyOperation should throw for negative values', () async {
      expect(
        () => riskyOperation(-1),
        throwsA(isA<Exception>()),
      );
    });

    test('riskyOperation should return doubled value for positive', () async {
      final result = await riskyOperation(5);
      expect(result, equals(10));
    });
  });

  group('Stream Examples', () {
    test('numberStream should yield correct numbers', () async {
      final numbers = <int>[];
      await for (final number in numberStream(3)) {
        numbers.add(number);
      }
      expect(numbers, equals([1, 2, 3]));
    });

    test('errorStream should throw exception', () async {
      expect(
        () async {
          await for (final _ in errorStream()) {
            // ignore
          }
        },
        throwsA(isA<Exception>()),
      );
    });

    test('transformedStream should yield string elements', () async {
      final elements = <String>[];
      await for (final element in transformedStream()) {
        elements.add(element);
      }
      expect(elements, equals(['Element 1', 'Element 2', 'Element 3', 'Element 4', 'Element 5']));
    });
  });

  group('Helper Functions', () {
    test('isEven should correctly identify even numbers', () {
      expect(isEven(2), isTrue);
      expect(isEven(3), isFalse);
      expect(isEven(0), isTrue);
    });

    test('doubleValue should double the input', () {
      expect(doubleValue(5), equals(10));
      expect(doubleValue(0), equals(0));
      expect(doubleValue(-3), equals(-6));
    });
  });
}