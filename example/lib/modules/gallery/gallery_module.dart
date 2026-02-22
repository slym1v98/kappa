import 'package:fkappa/fkappa.dart';
import 'presentation/pages/gallery_page.dart';

class GalleryModule extends FKappaModule {
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
