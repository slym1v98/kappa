import 'package:fkappa/fkappa.dart';
import '../../shared/services/i_auth_service.dart';

class AuthService implements IAuthService {
  final FKappaDio dio;
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

class UserModule extends FKappaModule {
  @override
  String get name => 'User';

  @override
  List<RouteBase> get routes => [];

  @override
  void registerDependencies(GetIt sl) {
    // 1. Inject Global FKappaDio into AuthService
    sl.registerLazySingleton<IAuthService>(() => AuthService(sl<FKappaDio>()));

    // 2. Expose to Global Registry
    FKappaServiceRegistry.register<IAuthService>(sl<IAuthService>());
  }
}
