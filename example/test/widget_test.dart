import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fkappa/kappa.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';

class MockStorage extends Mock implements Storage {}

class SimpleModule extends KappaModule {
  @override
  String get name => 'Simple';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/test',
      builder: (context, state) => const Scaffold(body: Text('Test Page')),
    ),
  ];

  @override
  void registerDependencies(GetIt sl) {}
}

void main() {
  setUp(() {
    GetIt.instance.reset();
  });

  testWidgets('Verify KappaApp initialization and navigation', (WidgetTester tester) async {
    // 1. Mock Storage
    final mockStorage = MockStorage();
    when(() => mockStorage.write(any(), any())).thenAnswer((_) async {});
    when(() => mockStorage.read(any())).thenReturn(null);

    // 2. Build our KappaApp with SimpleModule
    await tester.runAsync(() async {
      await tester.pumpWidget(
        KappaApp(
          modules: [SimpleModule()],
          initialRoute: '/test',
          storage: mockStorage,
        ),
      );

      // Wait for framework initialization
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pump();
    });

    // 3. Verify that we are on the Test Page
    await tester.pumpAndSettle();
    expect(find.text('Test Page'), findsOneWidget);
  });
}
