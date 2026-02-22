import 'package:kappa/kappa.dart';

/// The contract for data access.
/// Domain layer only knows about this interface.
abstract class ICounterRepository extends BaseRepository {
  Future<Either<Failure, int>> getCounterValue();
  Future<Either<Failure, int>> incrementCounter(int currentValue);
}
