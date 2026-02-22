import 'package:flownest_kappa/kappa.dart';
import '../../domain/repositories/i_counter_repository.dart';
import '../datasources/counter_local_data_source.dart';

/// Implementation of the repository using local data source.
class CounterRepositoryImpl extends ICounterRepository {
  final CounterLocalDataSource dataSource;

  CounterRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, int>> getCounterValue() async {
    try {
      final value = await dataSource.getCounter();
      return Right(value);
    } catch (e) {
      return Left(CacheFailure("Could not read counter: $e"));
    }
  }

  @override
  Future<Either<Failure, int>> incrementCounter(int currentValue) async {
    try {
      final value = await dataSource.increment(currentValue);
      return Right(value);
    } catch (e) {
      return Left(CacheFailure("Could not increment counter: $e"));
    }
  }
}
