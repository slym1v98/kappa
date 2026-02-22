import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kappa/kappa.dart';
import 'package:kappa_example/modules/counter/domain/usecases/increment_counter.dart';
import 'package:kappa_example/modules/counter/presentation/bloc/counter_bloc.dart';

class MockIncrementCounterUseCase extends Mock implements IncrementCounterUseCase {}

void main() {
  late CounterBloc bloc;
  late MockIncrementCounterUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockIncrementCounterUseCase();
    bloc = CounterBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('CounterBloc Tests', () {
    test('initial state should be CounterInitial', () {
      expect(bloc.state, CounterInitial());
    });

    blocTest<CounterBloc, CounterState>(
      'emits [Loading, Success] when IncrementEvent is added',
      build: () {
        when(() => mockUseCase(0)).thenAnswer((_) async => const Right(1));
        return bloc;
      },
      act: (bloc) => bloc.add(const IncrementEvent(0)),
      expect: () => [
        CounterLoading(),
        const CounterSuccess(1),
      ],
      verify: (_) {
        verify(() => mockUseCase(0)).called(1);
      },
    );

    blocTest<CounterBloc, CounterState>(
      'emits [Loading, Error] when UseCase fails',
      build: () {
        const failure = ServerFailure("Error occurred");
        when(() => mockUseCase(0)).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) => bloc.add(const IncrementEvent(0)),
      expect: () => [
        CounterLoading(),
        const CounterError("Error occurred"),
      ],
    );

    blocTest<CounterBloc, CounterState>(
      'emits [Success(0)] when ResetEvent is added',
      build: () => bloc,
      act: (bloc) => bloc.add(ResetEvent()),
      expect: () => [const CounterSuccess(0)],
    );
  });
}
