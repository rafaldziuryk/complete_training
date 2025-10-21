import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

/// Use case for getting concrete number trivia
class GetConcreteNumberTrivia implements UseCase<NumberTrivia, GetConcreteNumberTriviaParams> {
  final NumberTriviaRepository repository;
  
  const GetConcreteNumberTrivia(this.repository);
  
  @override
  Future<UseCaseResult<NumberTrivia>> call(GetConcreteNumberTriviaParams params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

/// Parameters for GetConcreteNumberTrivia use case
class GetConcreteNumberTriviaParams {
  final int number;
  
  const GetConcreteNumberTriviaParams({required this.number});
}
