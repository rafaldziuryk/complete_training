import '../entities/number_trivia.dart';
import '../../../../core/usecases/usecase.dart';

/// Abstract repository for number trivia operations
abstract class NumberTriviaRepository {
  /// Gets concrete number trivia by number
  Future<UseCaseResult<NumberTrivia>> getConcreteNumberTrivia(int number);
  
  /// Gets random number trivia
  Future<UseCaseResult<NumberTrivia>> getRandomNumberTrivia();
}
