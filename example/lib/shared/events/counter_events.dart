import 'package:flownest_kappa/kappa.dart';

/// Shared event for counter changes.
/// All modules can publish or subscribe to this.
class CounterIncrementedEvent extends KappaEvent {
  final int newValue;
  final DateTime timestamp;

  CounterIncrementedEvent(this.newValue) : timestamp = DateTime.now();
}
