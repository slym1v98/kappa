import 'package:flownest_kappa/kappa.dart';
import '../../shared/services/i_auth_service.dart';

class AuthService implements IAuthService {
  final KappaDio dio;
  String _cachedName = "Loading...";

  AuthService(this.dio) {
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final result = await dio.get('/user/profile');
    result.fold(
      (failure) => _cachedName = "Error Loading Name",
      (response) => _cachedName = response.data['name'],
    );
  }

  @override
  String getCurrentUserName() => _cachedName;

  @override
  bool isLoggedIn() => true;
}

class UserModule extends KappaModule {
  @override
  String get name => 'User';

  @override
  List<RouteBase> get routes => [];

  @override
  void registerDependencies(GetIt sl) {
    // 1. Inject Global KappaDio into AuthService
    sl.registerLazySingleton<IAuthService>(() => AuthService(sl<KappaDio>()));

    // 2. Expose to Global Registry
    KappaServiceRegistry.register<IAuthService>(sl<IAuthService>());
  }
}
