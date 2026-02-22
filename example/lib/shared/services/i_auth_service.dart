/// Public interface for Auth Service.
/// This will be registered in KappaServiceRegistry.
abstract class IAuthService {
  String getCurrentUserName();
  bool isLoggedIn();
}
