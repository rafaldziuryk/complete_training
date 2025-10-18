import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/number_trivia.dart';

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
  
  /// Maps DTO to Domain Entity
  NumberTrivia toEntity() {
    return NumberTrivia(
      text: text,
      number: number,
    );
  }
  
  /// Creates DTO from Domain Entity
  factory NumberTriviaModel.fromEntity(NumberTrivia entity) {
    return NumberTriviaModel(
      text: entity.text,
      number: entity.number,
    );
  }
}
