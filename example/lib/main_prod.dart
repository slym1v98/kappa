import 'package:flutter/material.dart';
import 'package:kappa/kappa.dart';
import 'modules/counter/counter_module.dart';
import 'modules/history/history_module.dart';
import 'modules/user/user_module.dart';
import 'modules/settings/settings_module.dart';
import 'modules/gallery/gallery_module.dart';
import 'modules/auth/auth_module.dart';
import 'shared/services/i_auth_service.dart';

void main() async {
  // Use a silent observer or Sentry in Prod
  Bloc.observer = KappaBlocObserver();

  const prodEnv = KappaEnv(
    flavor: KappaFlavor.prod,
    baseUrl: 'https://api.kappa.io', // Real production API
    sentryDsn: 'https://your-sentry-dsn@sentry.io/123',
  );

  runApp(
    KappaApp(
      title: 'Kappa Framework',
      env: prodEnv,
      debugShowCheckedModeBanner: false,
      modules: [
        UserModule(),
        AuthModule(),
        CounterModule(),
        HistoryModule(),
        SettingsModule(),
        GalleryModule(),
      ],
      initialRoute: '/settings',
      globalMiddlewares: [
        AuthMiddleware(
          isAuthenticated: () => GetIt.instance<IAuthService>().isLoggedIn(),
          loginPath: '/login',
        ),
        GuestMiddleware(
          isAuthenticated: () => GetIt.instance<IAuthService>().isLoggedIn(),
          homePath: '/settings',
        ),
      ],
    ),
  );
}
