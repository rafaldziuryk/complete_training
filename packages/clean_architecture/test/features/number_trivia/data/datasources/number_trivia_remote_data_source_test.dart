import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/core/error/exceptions.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUpAll(() {
    // Rejestracja fallback values dla Mocktail
    registerFallbackValue(Uri.parse('https://example.com'));
    registerFallbackValue(RequestOptions(path: ''));
  });

  setUp(() {
    mockDio = MockDio();
    dataSource = NumberTriviaRemoteDataSourceImpl(mockDio);
  });

  tearDown(() {
    // Reset mocka po każdym teście
    reset(mockDio);
  });

  tearDownAll(() {
    // Czyszczenie po wszystkich testach
    print('Remote data source tests completed');
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    const tNumberTriviaModel = NumberTriviaModel(
      text: 'Test trivia',
      number: tNumber,
    );

    test('should return NumberTriviaModel when the call to remote source is successful', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: 'Test trivia',
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      // Assert
      expect(result, equals(tNumberTriviaModel));
      verify(() => mockDio.get('https://complete-training.onrender.com/exact/$tNumber')).called(1);
    });

    test('should throw ServerException when the call to remote source is unsuccessful', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: 'Not Found',
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      // Act & Assert
      expect(
        () => dataSource.getConcreteNumberTrivia(tNumber),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw NetworkException when there is no internet connection', () async {
      // Arrange
      when(() => mockDio.get(any())).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      ));

      // Act & Assert
      expect(
        () => dataSource.getConcreteNumberTrivia(tNumber),
        throwsA(isA<NetworkException>()),
      );
    });

    test('should throw ServerException when there is a server error', () async {
      // Arrange
      when(() => mockDio.get(any())).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.badResponse,
        message: 'Server error',
      ));

      // Act & Assert
      expect(
        () => dataSource.getConcreteNumberTrivia(tNumber),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw ServerException when there is an unexpected error', () async {
      // Arrange
      when(() => mockDio.get(any())).thenThrow(Exception('Unexpected error'));

      // Act & Assert
      expect(
        () => dataSource.getConcreteNumberTrivia(tNumber),
        throwsA(isA<ServerException>()),
      );
    });

    test('should not call getRandomNumberTrivia when getting concrete number', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: 'Test trivia',
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      await dataSource.getConcreteNumberTrivia(tNumber);

      // Assert
      verify(() => mockDio.get('https://complete-training.onrender.com/exact/$tNumber')).called(1);
      verifyNever(() => mockDio.get('https://complete-training.onrender.com/random'));
    });
  });

  group('getRandomNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(
      text: 'Test random trivia',
      number: 0,
    );

    test('should return NumberTriviaModel when the call to remote source is successful', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: 'Test random trivia',
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      final result = await dataSource.getRandomNumberTrivia();

      // Assert
      expect(result, equals(tNumberTriviaModel));
      verify(() => mockDio.get('https://complete-training.onrender.com/random')).called(1);
    });

    test('should throw ServerException when the call to remote source is unsuccessful', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: 'Not Found',
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      // Act & Assert
      expect(
        () => dataSource.getRandomNumberTrivia(),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw NetworkException when there is no internet connection', () async {
      // Arrange
      when(() => mockDio.get(any())).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      ));

      // Act & Assert
      expect(
        () => dataSource.getRandomNumberTrivia(),
        throwsA(isA<NetworkException>()),
      );
    });

    test('should throw ServerException when there is a server error', () async {
      // Arrange
      when(() => mockDio.get(any())).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.badResponse,
        message: 'Server error',
      ));

      // Act & Assert
      expect(
        () => dataSource.getRandomNumberTrivia(),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw ServerException when there is an unexpected error', () async {
      // Arrange
      when(() => mockDio.get(any())).thenThrow(Exception('Unexpected error'));

      // Act & Assert
      expect(
        () => dataSource.getRandomNumberTrivia(),
        throwsA(isA<ServerException>()),
      );
    });

    test('should not call getConcreteNumberTrivia when getting random number', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: 'Test random trivia',
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      await dataSource.getRandomNumberTrivia();

      // Assert
      verify(() => mockDio.get('https://complete-training.onrender.com/random')).called(1);
      verifyNever(() => mockDio.get('https://complete-training.onrender.com/exact/1'));
    });
  });

  group('Advanced Mocktail Features', () {
    test('should demonstrate verifyInOrder usage', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: 'Test',
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      await dataSource.getConcreteNumberTrivia(1);
      await dataSource.getRandomNumberTrivia();
      await dataSource.getConcreteNumberTrivia(2);

      // Assert
      verifyInOrder([
        () => mockDio.get('https://complete-training.onrender.com/exact/1'),
        () => mockDio.get('https://complete-training.onrender.com/random'),
        () => mockDio.get('https://complete-training.onrender.com/exact/2'),
      ]);
    });

    test('should demonstrate verifyZeroInteractions', () async {
      // Arrange - nie ustawiamy żadnych when()
      
      // Act & Assert - nie wywołujemy żadnych metod
      verifyZeroInteractions(mockDio);
    });
  });
}
