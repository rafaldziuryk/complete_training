import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';
import '../../../../core/util/input_converter.dart';
import 'number_trivia_event.dart';
import 'number_trivia_state.dart';

/// BLoC for managing number trivia state
class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  final InputConverter _inputConverter;
  
  NumberTriviaBloc({
    required GetConcreteNumberTrivia getConcreteNumberTrivia,
    required GetRandomNumberTrivia getRandomNumberTrivia,
    required InputConverter inputConverter,
  })  : _getConcreteNumberTrivia = getConcreteNumberTrivia,
        _getRandomNumberTrivia = getRandomNumberTrivia,
        _inputConverter = inputConverter,
        super(const NumberTriviaInitial()) {
    
    on<GetTriviaForConcreteNumber>(_onGetTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_onGetTriviaForRandomNumber);
  }
  
  Future<void> _onGetTriviaForConcreteNumber(
    GetTriviaForConcreteNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    // Convert string to integer
    final inputResult = _inputConverter.stringToUnsignedInteger(event.numberString);
    
    switch (inputResult) {
      case UseCaseSuccess<int>(data: final integer):
        emit(const NumberTriviaLoading());
        
        final result = await _getConcreteNumberTrivia(
          GetConcreteNumberTriviaParams(number: integer),
        );
        
        switch (result) {
          case UseCaseSuccess<NumberTrivia>(data: final trivia):
            emit(NumberTriviaLoaded(trivia));
          case UseCaseFailure<NumberTrivia>(failure: final failure):
            emit(NumberTriviaError(_mapFailureToMessage(failure)));
        }
      case UseCaseFailure<int>(failure: final failure):
        emit(NumberTriviaError(_mapFailureToMessage(failure)));
    }
  }
  
  Future<void> _onGetTriviaForRandomNumber(
    GetTriviaForRandomNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(const NumberTriviaLoading());
    
    final result = await _getRandomNumberTrivia(const NoParams());
    
    switch (result) {
      case UseCaseSuccess<NumberTrivia>(data: final trivia):
        emit(NumberTriviaLoaded(trivia));
      case UseCaseFailure<NumberTrivia>(failure: final failure):
        emit(NumberTriviaError(_mapFailureToMessage(failure)));
    }
  }
  
  String _mapFailureToMessage(Failure failure) {
    return switch (failure) {
      ServerFailure() => 'Server Failure',
      CacheFailure() => 'Cache Failure',
      NetworkFailure() => 'Network Failure',
      ValidationFailure() => 'Invalid Input - The number must be a positive integer or zero.',
      UnknownFailure() => 'Unexpected error',
    };
  }
}
