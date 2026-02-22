import 'package:flutter_test/flutter_test.dart';
import 'package:kappa/kappa.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kappa_example/modules/counter/domain/repositories/i_counter_repository.dart';
import 'package:kappa_example/modules/counter/domain/usecases/increment_counter.dart';
import 'package:kappa_example/shared/events/counter_events.dart';

class MockCounterRepository extends Mock implements ICounterRepository {}

void main() {
  late IncrementCounterUseCase useCase;
  late MockCounterRepository mockRepository;

  setUp(() {
    mockRepository = MockCounterRepository();
    useCase = IncrementCounterUseCase(mockRepository);
  });

  group('IncrementCounterUseCase Tests', () {
    test('Should increment counter and emit CounterIncrementedEvent', () async {
      // Arrange
      const initialValue = 5;
      const expectedValue = 6;
      when(() => mockRepository.incrementCounter(initialValue))
          .thenAnswer((_) async => const Right(expectedValue));

      // Assert Event Bus
      final eventBusStream = KappaEventBus.on<CounterIncrementedEvent>();
      final expectation = expectLater(
        eventBusStream,
        emits(predicate<CounterIncrementedEvent>((e) => e.newValue == expectedValue)),
      );
      
      // Act
      final result = await useCase(initialValue);

      // Verify
      expect(result, const Right(expectedValue));
      verify(() => mockRepository.incrementCounter(initialValue)).called(1);
      
      // Await the expectation to finish
      await expectation;
    });

    test('Should return Failure when repository fails', () async {
      // Arrange
      const initialValue = 5;
      const failure = ServerFailure("Network error");
      when(() => mockRepository.incrementCounter(initialValue))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(initialValue);

      // Verify
      expect(result, const Left(failure));
      verify(() => mockRepository.incrementCounter(initialValue)).called(1);
    });
  });
}
