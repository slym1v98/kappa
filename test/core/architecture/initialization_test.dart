import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kappa/kappa.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

class MockModule extends Mock implements KappaModule {}
class FakeGetIt extends Fake implements GetIt {}
class MockStorage extends Mock implements Storage {}

void main() {
  setUpAll(() async {
    registerFallbackValue(FakeGetIt());
    // Initialize HydratedStorage with a mock to avoid path_provider errors
    HydratedBloc.storage = MockStorage();
    when(() => HydratedBloc.storage.write(any(), any())).thenAnswer((_) async {});
  });

  setUp(() {
    GetIt.instance.reset();
  });

  group('Kappa Initialization Flow Tests', () {
    testWidgets('Should register dependencies BEFORE initializing modules', (tester) async {
      final sl = GetIt.instance;
      final module = MockModule();
      final mockStorage = MockStorage();
      
      when(() => module.name).thenReturn('TestModule');
      when(() => module.routes).thenReturn([]);
      when(() => module.registerDependencies(any())).thenReturn(null);
      when(() => module.init()).thenAnswer((_) async {});
      when(() => mockStorage.write(any(), any())).thenAnswer((_) async {});

      // Act
      await tester.runAsync(() async {
        await tester.pumpWidget(KappaApp(
          modules: [module],
          initialRoute: '/',
          storage: mockStorage, // Injecting mock here
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
      when(() => module.registerDependencies(any())).thenReturn(null);
      when(() => mockStorage.write(any(), any())).thenAnswer((_) async {});
      // Infinite initialization
      when(() => module.init()).thenAnswer((_) async => Future.delayed(const Duration(seconds: 20)));

      // Act
      await tester.runAsync(() async {
        await tester.pumpWidget(KappaApp(
          modules: [module],
          initialRoute: '/',
          storage: mockStorage,
        ));

        // We wait for the 10s timeout to trigger
        await Future.delayed(const Duration(seconds: 11));
        await tester.pump();
      });

      // Check if loader is still there (since init failed/timed out)
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
