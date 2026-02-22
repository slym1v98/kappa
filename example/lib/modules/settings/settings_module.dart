import 'package:fkappa/fkappa.dart';
import 'presentation/bloc/settings_bloc.dart';
import 'presentation/pages/settings_page.dart';

class SettingsModule extends FKappaModule {
  @override
  String get name => 'Settings';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => FKappaPageTransition.zoom(
        child: BlocProvider(
          create: (context) => GetIt.instance<SettingsBloc>(),
          child: const SettingsPage(),
        ),
        key: state.pageKey,
      ),
    ),
  ];

  @override
  void registerDependencies(GetIt sl) {
    sl.registerSingleton(SettingsBloc());
  }
}
