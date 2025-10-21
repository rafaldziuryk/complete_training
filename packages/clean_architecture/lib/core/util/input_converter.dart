import '../error/failures.dart';
import '../usecases/usecase.dart';

/// Utility class for input validation and conversion
class InputConverter {
  /// Converts a string to an unsigned integer
  /// Returns UseCaseFailure with ValidationFailure if input is invalid
  UseCaseResult<int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) {
        return const UseCaseFailure(ValidationFailure('Number must be positive or zero'));
      }
      return UseCaseSuccess(integer);
    } catch (e) {
      return UseCaseFailure(ValidationFailure('Invalid input: $str'));
    }
  }
}
