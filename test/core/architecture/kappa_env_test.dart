import 'package:flutter_test/flutter_test.dart';
import 'package:fkappa/kappa.dart';

void main() {
  group('KappaEnv Tests', () {
    test('Should identify DEV environment correctly', () {
      const env = KappaEnv(
        flavor: KappaFlavor.dev,
        baseUrl: 'https://dev.api.com',
      );

      expect(env.isDev, isTrue);
      expect(env.isProd, isFalse);
      expect(env.baseUrl, 'https://dev.api.com');
    });

    test('Should identify PROD environment correctly', () {
      const env = KappaEnv(
        flavor: KappaFlavor.prod,
        baseUrl: 'https://prod.api.com',
      );

      expect(env.isProd, isTrue);
      expect(env.isDev, isFalse);
    });

    test('Should store extra configuration correctly', () {
      const env = KappaEnv(
        flavor: KappaFlavor.staging,
        baseUrl: 'https://staging.api.com',
        extra: {'debug_logs': true, 'retry_count': 3},
      );

      expect(env.extra['debug_logs'], isTrue);
      expect(env.extra['retry_count'], 3);
    });
  });
}
