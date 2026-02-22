import 'package:flownest_kappa/kappa.dart';

/// An event that is fired whenever the counter changes.
/// Other modules can listen to this event.
class CounterIncrementedEvent extends KappaEvent {
  final int newValue;

  const CounterIncrementedEvent(this.newValue);
}
