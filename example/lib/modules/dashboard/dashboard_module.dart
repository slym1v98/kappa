import 'package:fkappa/kappa.dart';
import 'presentation/pages/dashboard_page.dart';

class DashboardModule extends KappaModule {
  @override
  String get name => 'Dashboard';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) => KappaPageTransition.slideUp(
        child: const DashboardPage(),
        key: state.pageKey,
      ),
    ),
  ];

  @override
  void registerDependencies(GetIt sl) {}
}
