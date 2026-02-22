import 'package:fkappa/fkappa.dart';

/// Shared event for counter changes.
/// All modules can publish or subscribe to this.
class CounterIncrementedEvent extends FKappaEvent {
  final int newValue;
  final DateTime timestamp;

  CounterIncrementedEvent(this.newValue) : timestamp = DateTime.now();
}
