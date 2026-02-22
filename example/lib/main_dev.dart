import 'package:flutter/material.dart';
import 'package:flownest_kappa/kappa.dart';
import 'package:flownest_kappa/core/network/kappa_mock_interceptor.dart';
import 'modules/counter/counter_module.dart';
import 'modules/history/history_module.dart';
import 'modules/user/user_module.dart';
import 'modules/settings/settings_module.dart';
import 'modules/gallery/gallery_module.dart';
import 'modules/auth/auth_module.dart';
import 'shared/services/i_auth_service.dart';

void main() async {
  Bloc.observer = KappaBlocObserver();

  const devEnv = KappaEnv(
    flavor: KappaFlavor.dev,
    baseUrl: 'https://dev-api.kappa.io',
    extra: {'debugInfo': true},
  );

  runApp(
    KappaApp(
      title: '[DEV] Kappa App',
      env: devEnv,
      interceptors: [
        KappaMockInterceptor(
          mockData: {'/user/profile': {'name': 'Developer User'}},
          delay: const Duration(milliseconds: 200),
        ),
      ],
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
