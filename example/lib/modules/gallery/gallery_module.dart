import 'package:fkappa/kappa.dart';
import 'presentation/pages/gallery_page.dart';

class GalleryModule extends KappaModule {
  @override
  String get name => 'Gallery';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/gallery',
      builder: (context, state) => const GalleryPage(),
    ),
  ];

  @override
  void registerDependencies(GetIt sl) {}
}
