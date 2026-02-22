/// Base class for all failures in the application.
/// Use this class to standardize error handling in the Domain Layer.
abstract class Failure {
  final String message;
  final StackTrace? stackTrace;
  final dynamic exception;

  const Failure(this.message, {this.stackTrace, this.exception});

  @override
  String toString() => '$runtimeType: $message';
}

/// A standard Server Failure (e.g., 500 error, timeout).
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.stackTrace, super.exception});
}

/// A standard Cache Failure (e.g., local storage read/write error).
class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.stackTrace, super.exception});
}

/// A standard Business Logic Failure (e.g., invalid data, constraint violation).
class BusinessFailure extends Failure {
  const BusinessFailure(super.message, {super.stackTrace, super.exception});
}
