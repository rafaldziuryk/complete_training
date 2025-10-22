import '../error/failures.dart';

/// Base class for all use cases
abstract class UseCase<ReturnType, Params> {
  Future<UseCaseResult<ReturnType>> call(Params params);
}

/// Use case result sealed class for better error handling
sealed class UseCaseResult<T> {
  const UseCaseResult();
}

/// Success result
final class UseCaseSuccess<T> extends UseCaseResult<T> {
  final T data;
  
  const UseCaseSuccess(this.data);
}

/// Failure result
final class UseCaseFailure<T> extends UseCaseResult<T> {
  final Failure failure;
  
  const UseCaseFailure(this.failure);
}

/// Parameters for use cases that don't need any input
class NoParams {
  const NoParams();
}
