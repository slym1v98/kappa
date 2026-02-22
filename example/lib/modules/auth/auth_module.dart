import 'package:fkappa/fkappa.dart';
import 'presentation/pages/login_page.dart';

class AuthModule extends FKappaModule {
  @override
  String get name => 'Auth';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
  ];

  @override
  void registerDependencies(GetIt sl) {
    // Auth dependencies already registered in UserModule in this example
  }
}
