import 'package:fkappa/fkappa.dart';

/// An event that is fired whenever the counter changes.
/// Other modules can listen to this event.
class CounterIncrementedEvent extends FKappaEvent {
  final int newValue;

  const CounterIncrementedEvent(this.newValue);
}
