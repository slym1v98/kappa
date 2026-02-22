import 'package:fkappa/kappa.dart';
import 'data/datasources/counter_local_data_source.dart';
import 'data/repositories/counter_repository_impl.dart';
import 'domain/repositories/i_counter_repository.dart';
import 'domain/usecases/increment_counter.dart';
import 'presentation/bloc/counter_bloc.dart';
import 'presentation/pages/counter_page.dart';

class CounterModule extends KappaModule {
  @override
  String get name => 'Counter';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/counter',
      builder: (context, state) => BlocProvider(
        create: (context) => GetIt.instance<CounterBloc>(),
        child: const CounterPage(),
      ),
    ),
  ];

  @override
  void registerDependencies(GetIt sl) {
    // Data
    sl.registerLazySingleton(() => CounterLocalDataSource());
    sl.registerLazySingleton<ICounterRepository>(
      () => CounterRepositoryImpl(sl()),
    );

    // Domain
    sl.registerFactory(() => IncrementCounterUseCase(sl()));

    // Presentation
    sl.registerFactory(() => CounterBloc(sl()));
  }

  @override
  Future<void> init() async {
    // Optional: Perform async setup logic here
    print('Counter Module Initialized');
  }
}
