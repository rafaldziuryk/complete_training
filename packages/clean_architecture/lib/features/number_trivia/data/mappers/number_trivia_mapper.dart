import '../models/number_trivia_model.dart';
import '../../domain/entities/number_trivia.dart';

/// Mapper class for converting between NumberTriviaModel (DTO) and NumberTrivia (Entity)
class NumberTriviaMapper {
  /// Maps DTO to Domain Entity
  static NumberTrivia toEntity(NumberTriviaModel model) {
    return NumberTrivia(
      text: model.text,
      number: model.number,
    );
  }
  
  /// Maps Domain Entity to DTO
  static NumberTriviaModel toModel(NumberTrivia entity) {
    return NumberTriviaModel(
      text: entity.text,
      number: entity.number,
    );
  }
  
  /// Maps list of DTOs to list of Domain Entities
  static List<NumberTrivia> toEntityList(List<NumberTriviaModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }
  
  /// Maps list of Domain Entities to list of DTOs
  static List<NumberTriviaModel> toModelList(List<NumberTrivia> entities) {
    return entities.map((entity) => toModel(entity)).toList();
  }
}