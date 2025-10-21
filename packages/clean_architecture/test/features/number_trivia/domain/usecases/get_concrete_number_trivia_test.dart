import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  late GetConcreteNumberTrivia useCase;
  late MockNumberTriviaRepository mockRepository;

  setUpAll(() {
    // Rejestracja fallback values dla Mocktail
    registerFallbackValue(1);
    registerFallbackValue(const GetConcreteNumberTriviaParams(number: 1));
  });

  setUp(() {
    mockRepository = MockNumberTriviaRepository();
    useCase = GetConcreteNumberTrivia(mockRepository);
  });

  tearDown(() {
    // Reset mocka po każdym teście
    reset(mockRepository);
  });

  tearDownAll(() {
    // Czyszczenie po wszystkich testach
    print('GetConcreteNumberTrivia tests completed');
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'Test trivia', number: tNumber);
  const tParams = GetConcreteNumberTriviaParams(number: tNumber);

  group('call', () {
    test('should return UseCaseSuccess with NumberTrivia when repository call is successful', () async {
      // Arrange
      when(() => mockRepository.getConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const UseCaseSuccess(tNumberTrivia));

      // Act
      final result = await useCase.call(tParams);

      // Assert
      expect(result, isA<UseCaseSuccess<NumberTrivia>>());
      if (result is UseCaseSuccess<NumberTrivia>) {
        expect(result.data, equals(tNumberTrivia));
      }
      verify(() => mockRepository.getConcreteNumberTrivia(tNumber)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return UseCaseFailure when repository call fails', () async {
      // Arrange
      const tFailure = ServerFailure('Server error');
      when(() => mockRepository.getConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const UseCaseFailure<NumberTrivia>(tFailure));

      // Act
      final result = await useCase.call(tParams);

      // Assert
      expect(result, isA<UseCaseFailure<NumberTrivia>>());
      if (result is UseCaseFailure<NumberTrivia>) {
        expect(result.failure, equals(tFailure));
      }
      verify(() => mockRepository.getConcreteNumberTrivia(tNumber)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should call repository with correct number', () async {
      // Arrange
      when(() => mockRepository.getConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const UseCaseSuccess(tNumberTrivia));

      // Act
      await useCase.call(tParams);

      // Assert
      verify(() => mockRepository.getConcreteNumberTrivia(tNumber)).called(1);
    });

    test('should not call getRandomNumberTrivia when getting concrete number', () async {
      // Arrange
      when(() => mockRepository.getConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const UseCaseSuccess(tNumberTrivia));

      // Act
      await useCase.call(tParams);

      // Assert
      verify(() => mockRepository.getConcreteNumberTrivia(tNumber)).called(1);
      verifyNever(() => mockRepository.getRandomNumberTrivia());
    });
  });

  group('Advanced Use Case Tests', () {
    test('should demonstrate verifyInOrder for multiple operations', () async {
      // Arrange
      when(() => mockRepository.getConcreteNumberTrivia(any()))
          .thenAnswer((_) async => const UseCaseSuccess(tNumberTrivia));

      // Act
      await useCase.call(const GetConcreteNumberTriviaParams(number: 1));
      await useCase.call(const GetConcreteNumberTriviaParams(number: 2));
      await useCase.call(const GetConcreteNumberTriviaParams(number: 3));

      // Assert
      verifyInOrder([
        () => mockRepository.getConcreteNumberTrivia(1),
        () => mockRepository.getConcreteNumberTrivia(2),
        () => mockRepository.getConcreteNumberTrivia(3),
      ]);
    });

    test('should demonstrate verifyZeroInteractions when no calls are made', () async {
      // Arrange - nie wywołujemy żadnych metod
      
      // Act & Assert
      verifyZeroInteractions(mockRepository);
    });
  });
}
