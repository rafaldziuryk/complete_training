/// Data model for number trivia (DTO)
class NumberTriviaModel {
  final String text;
  final int number;
  
  const NumberTriviaModel({
    required this.text,
    required this.number,
  });
  
  /// Creates model from JSON
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'] as String,
      number: (json['number'] as num).toInt(),
    );
  }
  
  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}
