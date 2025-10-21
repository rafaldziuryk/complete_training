import '../../domain/entities/number_trivia.dart';

/// States for NumberTriviaBloc using sealed classes
sealed class NumberTriviaState {
  const NumberTriviaState();
}

/// Initial state
final class NumberTriviaInitial extends NumberTriviaState {
  const NumberTriviaInitial();
}

/// Loading state
final class NumberTriviaLoading extends NumberTriviaState {
  const NumberTriviaLoading();
}

/// Loaded state with trivia data
final class NumberTriviaLoaded extends NumberTriviaState {
  final NumberTrivia trivia;
  
  const NumberTriviaLoaded(this.trivia);
}

/// Error state with error message
final class NumberTriviaError extends NumberTriviaState {
  final String message;
  
  const NumberTriviaError(this.message);
}
