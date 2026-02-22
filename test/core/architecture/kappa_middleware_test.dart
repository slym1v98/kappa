import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flownest_kappa/kappa.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouterState extends Mock implements GoRouterState {}

void main() {
  late MockGoRouterState mockState;

  setUp(() {
    mockState = MockGoRouterState();
  });

  group('AuthMiddleware Tests', () {
    test('Should redirect to login when NOT authenticated', () {
      final middleware = AuthMiddleware(
        isAuthenticated: () => false,
        loginPath: '/login',
      );

      final result = middleware.handle(FakeBuildContext(), mockState);
      expect(result, '/login');
    });

    test('Should NOT redirect when authenticated', () {
      final middleware = AuthMiddleware(
        isAuthenticated: () => true,
      );

      final result = middleware.handle(FakeBuildContext(), mockState);
      expect(result, isNull);
    });
  });

  group('GuestMiddleware Tests', () {
    test('Should redirect to home when authenticated', () {
      final middleware = GuestMiddleware(
        isAuthenticated: () => true,
        homePath: '/home',
      );

      final result = middleware.handle(FakeBuildContext(), mockState);
      expect(result, '/home');
    });

    test('Should NOT redirect when NOT authenticated', () {
      final middleware = GuestMiddleware(
        isAuthenticated: () => false,
      );

      final result = middleware.handle(FakeBuildContext(), mockState);
      expect(result, isNull);
    });
  });
}

class FakeBuildContext extends Mock implements BuildContext {}
