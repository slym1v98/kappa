import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flownest_kappa/kappa.dart';
import 'package:kappa_example/modules/settings/settings_module.dart';
import 'package:kappa_example/modules/user/user_module.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}
class MockKappaDio extends Mock implements KappaDio {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    GetIt.instance.reset();
  });

  testWidgets('integration test for Kappa framework initialization', (WidgetTester tester) async {
    // 1. Mock Dependencies
    final mockStorage = MockStorage();
    final mockDio = MockKappaDio();
    
    when(() => mockStorage.write(any(), any())).thenAnswer((_) async {});
    when(() => mockStorage.read(any())).thenReturn(null);

    // Register Mock Dio
    GetIt.instance.registerSingleton<KappaDio>(mockDio);
    when(() => mockDio.get(any())).thenAnswer((_) async => Right(Response(
      requestOptions: RequestOptions(path: ''),
      data: {'name': 'Test User'},
      statusCode: 200,
    )));

    // 2. Build the Kappa application
    await tester.runAsync(() async {
      await tester.pumpWidget(
        KappaApp(
          modules: [
            UserModule(),
            SettingsModule(),
          ],
          initialRoute: '/settings',
          storage: mockStorage,
        ),
      );

      // Wait for async initialization
      await Future.delayed(const Duration(milliseconds: 500));
      await tester.pump();
    });

    // 3. Verify core framework elements
    expect(find.text('Settings'), findsWidgets);
    
    // Verify that we can interact with Kappa elements
    expect(find.byType(KappaButton), findsWidgets);
  });
}
