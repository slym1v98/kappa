import 'package:flownest_kappa/kappa.dart';
import '../../domain/repositories/i_counter_repository.dart';
import '../../../../shared/events/counter_events.dart'; // Using the shared event

/// Business Logic: Increment counter and notify Event Bus.
class IncrementCounterUseCase extends BaseUseCase<int, int> {
  final ICounterRepository repository;

  IncrementCounterUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(int currentValue) async {
    final result = await repository.incrementCounter(currentValue);

    return result.map((newValue) {
      // Notify other modules that counter has changed via Event Bus
      KappaEventBus.emit(CounterIncrementedEvent(newValue));
      return newValue;
    });
  }
}
