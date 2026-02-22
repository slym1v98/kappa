import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'modules/kappa_module.dart';
import 'ui/toolkit/kappa_responsive.dart';
import 'ui/components/kappa_loading_overlay.dart';
import 'core/architecture/kappa_middleware.dart';
import 'core/architecture/kappa_env.dart';
import 'core/network/kappa_dio.dart';

/// The main entry point for a FKappa application.
class FKappaApp extends StatefulWidget {
  final List<FKappaModule> modules;
  final String initialRoute;
  final List<FKappaMiddleware> globalMiddlewares;
  final Storage? storage;
  final String? baseUrl;
  final FKappaEnv? env; // Added for flavor support
  final List<Interceptor>? interceptors;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final String title;
  final bool debugShowCheckedModeBanner;

  const FKappaApp({
    super.key,
    required this.modules,
    required this.initialRoute,
    this.globalMiddlewares = const [],
    this.storage,
    this.baseUrl,
    this.env,
    this.interceptors,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.title = 'fkappa App',
    this.debugShowCheckedModeBanner = true,
  });

  @override
  State<FKappaApp> createState() => _FKappaAppState();
}

class _FKappaAppState extends State<FKappaApp> {
  late final GoRouter _router;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeFramework();
  }

  Future<void> _initializeFramework() async {
    final sl = GetIt.instance;
    final stopwatch = Stopwatch()..start();

    try {
      // 1. Initialize Hydrated Storage
      if (widget.storage != null) {
        HydratedBloc.storage = widget.storage!;
      } else {
        HydratedBloc.storage = await HydratedStorage.build(
          storageDirectory: kIsWeb
              ? HydratedStorageDirectory.web
              : HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
        );
      }

      // 2. Initialize Global Networking (FKappaDio)
      final effectiveBaseUrl = widget.env?.baseUrl ?? widget.baseUrl;
      if (effectiveBaseUrl != null && !sl.isRegistered<FKappaDio>()) {
        if (kDebugMode) print('fkappa: Initializing Global Networking with baseUrl: $effectiveBaseUrl (Flavor: ${widget.env?.flavor})');
        final kappaDio = FKappaDio(
          baseUrl: effectiveBaseUrl,
          interceptors: widget.interceptors,
        );
        sl.registerSingleton<FKappaDio>(kappaDio);
      }

      // 3. Register Env into DI for global access
      if (widget.env != null && !sl.isRegistered<FKappaEnv>()) {
        sl.registerSingleton<FKappaEnv>(widget.env!);
      }

      // 3. Validate Modules and Register Dependencies (Skip Lazy Modules)
      final Set<String> moduleNames = {};
      for (final module in widget.modules) {
        if (moduleNames.contains(module.name)) {
          throw Exception('Duplicate Module detected: ${module.name}');
        }
        moduleNames.add(module.name);
        
        if (!module.isLazy) {
          if (kDebugMode) print('fkappa: Registering dependencies for [${module.name}]');
          module.registerDependencies(sl);
        }
      }

      // 4. Initialize modules (Skip Lazy Modules)
      for (final module in widget.modules) {
        if (!module.isLazy) {
          if (kDebugMode) print('fkappa: Initializing module [${module.name}]');
          await module.init().timeout(const Duration(seconds: 10));
        }
      }

      // 4. Collect routes from all modules
      final List<RouteBase> allRoutes = [];
      for (final module in widget.modules) {
        allRoutes.addAll(module.routes);
      }

      // 5. Configure GoRouter
      _router = GoRouter(
        initialLocation: widget.initialRoute,
        routes: allRoutes,
        debugLogDiagnostics: widget.debugShowCheckedModeBanner,
        redirect: (context, state) async {
          for (final middleware in widget.globalMiddlewares) {
            final redirectPath = await middleware.handle(context, state);
            if (redirectPath != null) return redirectPath;
          }
          return null;
        },
      );

      if (kDebugMode) {
        print('fkappa Framework initialized successfully in ${stopwatch.elapsedMilliseconds}ms');
      }

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('fkappa Initialization Error: $e');
        print(stack);
      }
      // You could show a Global Error Screen here if needed
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp.router(
      title: widget.title,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      themeMode: widget.themeMode,
      routerConfig: _router,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: FKappaLoadingOverlay(child: child!),
        breakpoints: FKappaResponsive.breakpoints,
      ),
    );
  }
}
