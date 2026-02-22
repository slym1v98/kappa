import 'package:fkappa/fkappa.dart';
import 'presentation/pages/dashboard_page.dart';

class DashboardModule extends FKappaModule {
  @override
  String get name => 'Dashboard';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) => FKappaPageTransition.slideUp(
        child: const DashboardPage(),
        key: state.pageKey,
      ),
    ),
  ];

  @override
  void registerDependencies(GetIt sl) {}
}
