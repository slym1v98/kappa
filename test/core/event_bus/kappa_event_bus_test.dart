import 'package:flutter_test/flutter_test.dart';
import 'package:fkappa/fkappa.dart';

class TestEvent extends FKappaEvent {
  final String data;
  const TestEvent(this.data);
}

class AnotherEvent extends FKappaEvent {}

void main() {
  group('FKappaEventBus Tests', () {
    test('Should emit and receive events of the same type', () async {
      final eventBus = FKappaEventBus.on<TestEvent>();
      const testData = "Hello Event Bus";

      expectLater(
        eventBus,
        emits(predicate<TestEvent>((event) => event.data == testData)),
      );

      FKappaEventBus.emit(const TestEvent(testData));
    });

    test('Should NOT receive events of a different type', () async {
      final eventBus = FKappaEventBus.on<TestEvent>();
      bool received = false;

      eventBus.listen((_) => received = true);

      FKappaEventBus.emit(AnotherEvent());
      
      await Future.delayed(const Duration(milliseconds: 50));
      expect(received, isFalse);
    });
  });
}
