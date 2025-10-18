import 'package:json_annotation/json_annotation.dart';

part 'number_trivia_model.g.dart';

/// Data model for number trivia (DTO)
@JsonSerializable()
class NumberTriviaModel {
  final String text;
  final int number;
  
  const NumberTriviaModel({
    required this.text,
    required this.number,
  });
  
  /// Creates model from JSON
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) => 
      _$NumberTriviaModelFromJson(json);
  
  /// Converts model to JSON
  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);
}
