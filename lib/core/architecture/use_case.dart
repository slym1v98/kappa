import 'package:fpdart/fpdart.dart';
import '../error/failure.dart';

/// The contract for all Use Cases in the application.
///
/// [Type] is the return type of the use case when successful.
/// [Params] is the parameter type required by the use case.
///
/// Example:
/// ```dart
/// class GetUser implements BaseUseCase<User, String> {
///   final UserRepository repository;
///
///   GetUser(this.repository);
///
///   @override
///   Future<Either<Failure, User>> call(String userId) async {
///     return repository.getUser(userId);
///   }
/// }
/// ```
abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// A special parameter class for use cases that don't require any arguments.
class NoParams {
  const NoParams();
}
