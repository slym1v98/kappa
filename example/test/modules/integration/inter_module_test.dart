import 'package:flutter_test/flutter_test.dart';
import 'package:fkappa/fkappa.dart';
import 'package:kappa_example/shared/events/counter_events.dart';
import 'package:kappa_example/modules/history/presentation/bloc/history_bloc.dart';

void main() {
  late HistoryBloc historyBloc;

  setUp(() {
    // Initializing the real HistoryBloc
    // As it registers for EventBus in its constructor
    historyBloc = HistoryBloc();
  });

  tearDown(() {
    historyBloc.close();
  });

  group('Inter-module Integration Tests', () {
    test('HistoryBloc should record events from Event Bus', () async {
      // 1. Arrange: verify history is empty
      expect(historyBloc.state.logs, isEmpty);

      // 2. Act: Emit an event to the global bus (simulating CounterModule action)
      final event = CounterIncrementedEvent(10);
      FKappaEventBus.emit(event);

      // 3. Assert: Wait for HistoryBloc to process the event
      // Since it's reactive, we wait for the next state
      await Future.delayed(const Duration(milliseconds: 100));

      expect(historyBloc.state.logs.length, 1);
      expect(historyBloc.state.logs.first['value'], 10);
      expect(historyBloc.state.logs.first['time'], event.timestamp);
    });

    test('HistoryBloc should handle multiple events correctly', () async {
      // Act
      FKappaEventBus.emit(CounterIncrementedEvent(1));
      FKappaEventBus.emit(CounterIncrementedEvent(2));
      FKappaEventBus.emit(CounterIncrementedEvent(3));

      await Future.delayed(const Duration(milliseconds: 100));

      // Assert: Verify log order (newest first as implemented in HistoryBloc)
      expect(historyBloc.state.logs.length, 3);
      expect(historyBloc.state.logs[0]['value'], 3);
      expect(historyBloc.state.logs[1]['value'], 2);
      expect(historyBloc.state.logs[2]['value'], 1);
    });
  });
}
