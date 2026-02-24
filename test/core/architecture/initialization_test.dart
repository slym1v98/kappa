import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fkappa/fkappa.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MockModule extends Mock implements FKappaModule {}
class FakeGetIt extends Fake implements GetIt {}
class MockStorage extends Mock implements Storage {}

void main() {
  setUpAll(() async {
    registerFallbackValue(FakeGetIt());
    HydratedBloc.storage = MockStorage();
    when(() => HydratedBloc.storage.write(any(), any())).thenAnswer((_) async {});
  });

  setUp(() {
    GetIt.instance.reset();
  });

  group('FKappa Initialization Flow Tests', () {
    testWidgets('Should register dependencies BEFORE initializing modules', (tester) async {
      final sl = GetIt.instance;
      final module = MockModule();
      final mockStorage = MockStorage();
      
      when(() => module.name).thenReturn('TestModule');
      when(() => module.routes).thenReturn([]);
      when(() => module.isLazy).thenReturn(false);
      when(() => module.registerDependencies(any())).thenReturn(null);
      when(() => module.init()).thenAnswer((_) async {});
      when(() => mockStorage.write(any(), any())).thenAnswer((_) async {});

      // Act
      await tester.runAsync(() async {
        await tester.pumpWidget(FKappaApp(
          modules: [module],
          initialRoute: '/',
          storage: mockStorage,
        ));

        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        await tester.pump();
      });

      // Verify sequence
      verify(() => module.registerDependencies(sl)).called(1);
      verify(() => module.init()).called(1);
    });

    testWidgets('Should handle initialization timeout correctly', (tester) async {
      final module = MockModule();
      final mockStorage = MockStorage();
      
      when(() => module.name).thenReturn('TimeoutModule');
      when(() => module.routes).thenReturn([]);
      when(() => module.isLazy).thenReturn(false);
      when(() => module.registerDependencies(any())).thenReturn(null);
      when(() => mockStorage.write(any(), any())).thenAnswer((_) async {});
      
      when(() => module.init()).thenAnswer((_) async => Future.delayed(const Duration(seconds: 20)));

      // Act
      await tester.runAsync(() async {
        await tester.pumpWidget(FKappaApp(
          modules: [module],
          initialRoute: '/',
          storage: mockStorage,
        ));

        await Future.delayed(const Duration(seconds: 11));
        await tester.pump();
      });

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
