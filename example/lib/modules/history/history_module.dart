import 'package:fkappa/kappa.dart';
import 'package:get_it/get_it.dart';
import 'presentation/bloc/history_bloc.dart';
import 'presentation/pages/history_page.dart';

class HistoryModule extends KappaModule {
  @override
  String get name => 'History';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/history',
      builder: (context, state) => BlocProvider.value(
        value: GetIt.instance<HistoryBloc>(),
        child: const HistoryPage(),
      ),
    ),
  ];

  @override
  void registerDependencies(GetIt sl) {
    // Register as a regular Singleton (not lazy) so it starts 
    // listening to the Event Bus as soon as the app starts.
    sl.registerSingleton(HistoryBloc());
  }

  @override
  Future<void> init() async {
    print('History Module Initialized & Listening to Event Bus');
  }
}
