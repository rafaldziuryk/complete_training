import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  late GetRandomNumberTrivia useCase;
  late MockNumberTriviaRepository mockRepository;

  setUpAll(() {
    // Rejestracja fallback values dla Mocktail
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    mockRepository = MockNumberTriviaRepository();
    useCase = GetRandomNumberTrivia(mockRepository);
  });

  tearDown(() {
    // Reset mocka po każdym teście
    reset(mockRepository);
  });

  tearDownAll(() {
    // Czyszczenie po wszystkich testach
    print('GetRandomNumberTrivia tests completed');
  });

  const tNumberTrivia = NumberTrivia(text: 'Test random trivia', number: 0);
  const tParams = NoParams();

  group('call', () {
    test('should return UseCaseSuccess with NumberTrivia when repository call is successful', () async {
      // Arrange
      when(() => mockRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const UseCaseSuccess(tNumberTrivia));

      // Act
      final result = await useCase.call(tParams);

      // Assert
      expect(result, isA<UseCaseSuccess<NumberTrivia>>());
      if (result is UseCaseSuccess<NumberTrivia>) {
        expect(result.data, equals(tNumberTrivia));
      }
      verify(() => mockRepository.getRandomNumberTrivia()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return UseCaseFailure when repository call fails', () async {
      // Arrange
      const tFailure = ServerFailure('Server error');
      when(() => mockRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const UseCaseFailure<NumberTrivia>(tFailure));

      // Act
      final result = await useCase.call(tParams);

      // Assert
      expect(result, isA<UseCaseFailure<NumberTrivia>>());
      if (result is UseCaseFailure<NumberTrivia>) {
        expect(result.failure, equals(tFailure));
      }
      verify(() => mockRepository.getRandomNumberTrivia()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should call repository with no parameters', () async {
      // Arrange
      when(() => mockRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const UseCaseSuccess(tNumberTrivia));

      // Act
      await useCase.call(tParams);

      // Assert
      verify(() => mockRepository.getRandomNumberTrivia()).called(1);
    });

    test('should not call getConcreteNumberTrivia when getting random number', () async {
      // Arrange
      when(() => mockRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const UseCaseSuccess(tNumberTrivia));

      // Act
      await useCase.call(tParams);

      // Assert
      verify(() => mockRepository.getRandomNumberTrivia()).called(1);
      verifyNever(() => mockRepository.getConcreteNumberTrivia(any()));
    });
  });

  group('Advanced Random Use Case Tests', () {
    test('should demonstrate verifyInOrder for multiple random calls', () async {
      // Arrange
      when(() => mockRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const UseCaseSuccess(tNumberTrivia));

      // Act
      await useCase.call(tParams);
      await useCase.call(tParams);
      await useCase.call(tParams);

      // Assert
      verifyInOrder([
        () => mockRepository.getRandomNumberTrivia(),
        () => mockRepository.getRandomNumberTrivia(),
        () => mockRepository.getRandomNumberTrivia(),
      ]);
    });

    test('should demonstrate verifyZeroInteractions when no calls are made', () async {
      // Arrange - nie wywołujemy żadnych metod
      
      // Act & Assert
      verifyZeroInteractions(mockRepository);
    });
  });
}
