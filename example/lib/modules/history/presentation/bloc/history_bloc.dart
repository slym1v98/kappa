import 'package:flownest_kappa/kappa.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import '../../../../shared/events/counter_events.dart';

// --- Events ---
abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
  @override
  List<Object?> get props => [];
}

class RecordEvent extends HistoryEvent {
  final int value;
  final DateTime timestamp;
  const RecordEvent(this.value, this.timestamp);

  @override
  List<Object?> get props => [value, timestamp];
}

class ClearHistoryEvent extends HistoryEvent {}

// --- States ---
class HistoryState extends Equatable {
  final List<Map<String, dynamic>> logs;
  const HistoryState({this.logs = const []});

  @override
  List<Object?> get props => [logs];
}

// --- BLoC ---
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  StreamSubscription? _eventSubscription;

  HistoryBloc() : super(const HistoryState()) {
    
    on<RecordEvent>((event, emit) {
      final newLogs = List<Map<String, dynamic>>.from(state.logs);
      newLogs.insert(0, {
        'value': event.value,
        'time': event.timestamp,
      });
      emit(HistoryState(logs: newLogs));
    });

    on<ClearHistoryEvent>((event, emit) => emit(const HistoryState()));

    // Listen to Global Event Bus and store subscription
    _eventSubscription = KappaEventBus.on<CounterIncrementedEvent>().listen((event) {
      if (!isClosed) {
        add(RecordEvent(event.newValue, event.timestamp));
      }
    });
  }

  @override
  Future<void> close() {
    _eventSubscription?.cancel();
    return super.close();
  }
}
