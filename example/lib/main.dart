import 'package:flutter/material.dart';
import 'package:flownest_kappa/kappa.dart';
import 'modules/counter/counter_module.dart';
import 'modules/history/history_module.dart';
import 'modules/user/user_module.dart';
import 'modules/settings/settings_module.dart';
import 'modules/gallery/gallery_module.dart';
import 'modules/auth/auth_module.dart';
import 'modules/dashboard/dashboard_module.dart';
import 'shared/services/i_auth_service.dart';

void main() async {
  // 1. Setup Global Error Observer
  Bloc.observer = KappaBlocObserver();

  runApp(
    KappaApp(
      title: 'Kappa Enterprise Demo',
      baseUrl: 'https://api.kappa.io',
      modules: [
        UserModule(),
        AuthModule(),
        CounterModule(),
        HistoryModule(),
        SettingsModule(),
        GalleryModule(),
        DashboardModule(), // Register Dashboard
      ],
      initialRoute: '/login',
      globalMiddlewares: [
        // AuthMiddleware(
        //   isAuthenticated: () => GetIt.instance<IAuthService>().isLoggedIn(),
        //   loginPath: '/login',
        // ),
        // GuestMiddleware(
        //   isAuthenticated: () => GetIt.instance<IAuthService>().isLoggedIn(),
        //   homePath: '/settings',
        // ),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    ),
  );
}
