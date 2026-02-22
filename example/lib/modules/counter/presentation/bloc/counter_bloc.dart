import 'package:flownest_kappa/kappa.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/increment_counter.dart';

// --- Events ---
abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

class IncrementEvent extends CounterEvent {
  final int currentValue;
  const IncrementEvent(this.currentValue);
}

class ResetEvent extends CounterEvent {}

// --- States ---
abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object?> get props => [];
}

class CounterInitial extends CounterState {}

class CounterLoading extends CounterState {}

class CounterSuccess extends CounterState {
  final int value;
  const CounterSuccess(this.value);

  @override
  List<Object?> get props => [value];
}

class CounterError extends CounterState {
  final String message;
  const CounterError(this.message);

  @override
  List<Object?> get props => [message];
}

// --- BLoC ---
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final IncrementCounterUseCase incrementUseCase;

  CounterBloc(this.incrementUseCase) : super(CounterInitial()) {
    on<IncrementEvent>((event, emit) async {
      emit(CounterLoading());
      final result = await incrementUseCase(event.currentValue);
      
      result.fold(
        (failure) => emit(CounterError(failure.message)),
        (newValue) => emit(CounterSuccess(newValue)),
      );
    });

    on<ResetEvent>((event, emit) => emit(const CounterSuccess(0)));
  }
}
