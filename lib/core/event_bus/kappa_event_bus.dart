import 'dart:async';

/// Base class for all events in the Kappa framework.
/// Extend this class to create custom events (e.g., UserLoggedInEvent).
abstract class KappaEvent {
  const KappaEvent();
}

/// A simple, reactive Event Bus for inter-module communication.
/// Modules publish events here, and other modules subscribe to react.
class KappaEventBus {
  static final StreamController<KappaEvent> _controller =
      StreamController<KappaEvent>.broadcast();

  /// Publish an event to all subscribers.
  static void emit(KappaEvent event) {
    _controller.add(event);
  }

  /// Listen for a specific type of event.
  static Stream<T> on<T extends KappaEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  /// Dispose the Event Bus (e.g., when the app shuts down).
  static void dispose() {
    _controller.close();
  }
}
