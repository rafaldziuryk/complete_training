/// Base failure class for all errors in the application
sealed class Failure {
  final String message;
  
  const Failure(this.message);
}

/// Server-related failures
final class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Cache-related failures
final class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Network connectivity failures
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Input validation failures
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Unknown/unexpected failures
final class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
