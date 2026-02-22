/// Public interface for Auth Service.
/// This will be registered in FKappaServiceRegistry.
abstract class IAuthService {
  String getCurrentUserName();
  bool isLoggedIn();
}
