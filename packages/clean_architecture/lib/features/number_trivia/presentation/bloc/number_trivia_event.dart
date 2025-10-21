/// Events for NumberTriviaBloc using sealed classes
sealed class NumberTriviaEvent {
  const NumberTriviaEvent();
}

/// Event to get trivia for a concrete number
final class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;
  
  const GetTriviaForConcreteNumber(this.numberString);
}

/// Event to get trivia for a random number
final class GetTriviaForRandomNumber extends NumberTriviaEvent {
  const GetTriviaForRandomNumber();
}
