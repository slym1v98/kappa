import 'package:flutter_test/flutter_test.dart';
import 'package:fkappa/kappa.dart';

class TestEvent extends KappaEvent {
  final String data;
  const TestEvent(this.data);
}

class AnotherEvent extends KappaEvent {}

void main() {
  group('KappaEventBus Tests', () {
    test('Should emit and receive events of the same type', () async {
      final eventBus = KappaEventBus.on<TestEvent>();
      const testData = "Hello Event Bus";

      expectLater(
        eventBus,
        emits(predicate<TestEvent>((event) => event.data == testData)),
      );

      KappaEventBus.emit(const TestEvent(testData));
    });

    test('Should NOT receive events of a different type', () async {
      final eventBus = KappaEventBus.on<TestEvent>();
      bool received = false;

      eventBus.listen((_) => received = true);

      KappaEventBus.emit(AnotherEvent());
      
      // Wait a bit to ensure no event was received
      await Future.delayed(const Duration(milliseconds: 50));
      expect(received, isFalse);
    });
  });
}
