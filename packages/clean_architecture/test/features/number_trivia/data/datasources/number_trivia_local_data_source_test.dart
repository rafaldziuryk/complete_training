import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/core/error/exceptions.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUpAll(() {
    // Rejestracja fallback values dla Mocktail
    registerFallbackValue('test_key');
    registerFallbackValue('test_value');
  });

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  tearDown(() {
    // Reset mocka po każdym teście
    reset(mockSharedPreferences);
  });

  tearDownAll(() {
    // Czyszczenie po wszystkich testach
    print('Local data source tests completed');
  });

  group('getLastNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(
      text: 'Test trivia',
      number: 1,
    );
    const tJsonString = '{"text":"Test trivia","number":1}';

    test('should return NumberTriviaModel from SharedPreferences when there is one in the cache', () async {
      // Arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(tJsonString);

      // Act
      final result = await dataSource.getLastNumberTrivia();

      // Assert
      expect(result, equals(tNumberTriviaModel));
      verify(() => mockSharedPreferences.getString(NumberTriviaLocalDataSourceImpl.cachedNumberTrivia)).called(1);
    });

    test('should throw CacheException when there is not a cached value', () async {
      // Arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      // Act & Assert
      expect(
        () => dataSource.getLastNumberTrivia(),
        throwsA(isA<CacheException>()),
      );
    });

    test('should throw CacheException when there is an invalid cached value', () async {
      // Arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn('invalid json');

      // Act & Assert
      expect(
        () => dataSource.getLastNumberTrivia(),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(
      text: 'Test trivia',
      number: 1,
    );

    test('should call SharedPreferences to cache the data', () async {
      // Arrange
      when(() => mockSharedPreferences.setString(any(), any())).thenAnswer((_) async => true);

      // Act
      await dataSource.cacheNumberTrivia(tNumberTriviaModel);

      // Assert
      final expectedJsonString = '{"text":"Test trivia","number":1}';
      verify(() => mockSharedPreferences.setString(
        NumberTriviaLocalDataSourceImpl.cachedNumberTrivia,
        expectedJsonString,
      )).called(1);
    });

    test('should throw CacheException when SharedPreferences fails to cache the data', () async {
      // Arrange
      when(() => mockSharedPreferences.setString(any(), any())).thenThrow(Exception('Cache failed'));

      // Act & Assert
      expect(
        () => dataSource.cacheNumberTrivia(tNumberTriviaModel),
        throwsA(isA<CacheException>()),
      );
    });

    test('should not call getString when caching data', () async {
      // Arrange
      when(() => mockSharedPreferences.setString(any(), any())).thenAnswer((_) async => true);

      // Act
      await dataSource.cacheNumberTrivia(tNumberTriviaModel);

      // Assert
      verify(() => mockSharedPreferences.setString(any(), any())).called(1);
      verifyNever(() => mockSharedPreferences.getString(any()));
    });
  });

  group('Advanced Local Data Source Tests', () {
    test('should demonstrate verifyInOrder for cache and retrieve operations', () async {
      // Arrange
      when(() => mockSharedPreferences.setString(any(), any())).thenAnswer((_) async => true);
      when(() => mockSharedPreferences.getString(any())).thenReturn('{"text":"Test","number":1}');

      // Act
      const tNumberTriviaModel = NumberTriviaModel(text: 'Test trivia', number: 1);
      await dataSource.cacheNumberTrivia(tNumberTriviaModel);
      await dataSource.getLastNumberTrivia();

      // Assert
      verifyInOrder([
        () => mockSharedPreferences.setString(any(), any()),
        () => mockSharedPreferences.getString(any()),
      ]);
    });

    test('should demonstrate verifyZeroInteractions when no operations are performed', () async {
      // Arrange - nie wywołujemy żadnych metod
      
      // Act & Assert
      verifyZeroInteractions(mockSharedPreferences);
    });
  });
}
