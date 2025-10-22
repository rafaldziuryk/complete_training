import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

/// Use case for getting random number trivia
class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;
  
  const GetRandomNumberTrivia(this.repository);
  
  @override
  Future<UseCaseResult<NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
