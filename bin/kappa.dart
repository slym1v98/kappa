import 'dart:io';
import 'package:args/args.dart';
import 'package:recase/recase.dart';

void main(List<String> args) {
  final parser = ArgParser()
    ..addCommand('generate');

  final results = parser.parse(args);

  if (results.command == null) {
    _printHelp();
    return;
  }

  final generateCommand = results.command!;
  if (generateCommand.name == 'generate') {
    final subCommand = generateCommand.command;
    if (subCommand == null || subCommand.rest.isEmpty) {
      _printHelp();
      return;
    }

    final type = subCommand.name; // module, usecase, bloc, repository, page
    final argsList = subCommand.rest;

    switch (type) {
      case 'module':
        _generateModule(argsList.first);
        break;
      case 'usecase':
        if (argsList.length < 2) return _error('Usage: kappa generate usecase <module> <name>');
        _generateUseCase(argsList[0], argsList[1]);
        break;
      case 'bloc':
        if (argsList.length < 2) return _error('Usage: kappa generate bloc <module> <name>');
        _generateBloc(argsList[0], argsList[1]);
        break;
      case 'repository':
        if (argsList.length < 2) return _error('Usage: kappa generate repository <module> <name>');
        _generateRepository(argsList[0], argsList[1]);
        break;
      case 'page':
        if (argsList.length < 2) return _error('Usage: kappa generate page <module> <name>');
        _generatePage(argsList[0], argsList[1]);
        break;
      case 'datasource':
        if (argsList.length < 2) return _error('Usage: kappa generate datasource <module> <name>');
        _generateDataSource(argsList[0], argsList[1]);
        break;
      case 'widget':
        if (argsList.length < 2) return _error('Usage: kappa generate widget <module> <name>');
        _generateWidget(argsList[0], argsList[1]);
        break;
      default:
        _printHelp();
    }
  }
}

void _printHelp() {
  print('Flownest Kappa CLI v1.0.0');
  print('Usage: flownest_kappa generate <type> [arguments]');
  print('\nCommands:');
  print('  module <name>                     - Create a full module structure');
  print('  usecase <module> <name>           - Create a UseCase in a module');
  print('  bloc <module> <name>              - Create a BLoC in a module');
  print('  repository <module> <name>        - Create a Repository (Interface + Impl)');
  print('  datasource <module> <name>        - Create a DataSource (Interface + Remote Impl)');
  print('  page <module> <name>              - Create a new Page widget');
  print('  widget <module> <name>            - Create a reusable widget in a module');
}

void _error(String msg) => print('❌ Error: $msg');

// --- Generators ---

void _generateDataSource(String module, String name) {
  final rc = ReCase(name);
  final fileName = rc.snakeCase;
  final className = rc.pascalCase;
  
  final dir = 'lib/modules/$module/data/datasources';

  Directory(dir).createSync(recursive: true);

  File('$dir/${fileName}_remote_data_source.dart').writeAsStringSync('''
import 'package:flownest_kappa/kappa.dart';

abstract class I${className}RemoteDataSource extends BaseDataSource {
  // TODO: Add methods (e.g., Future<Response> getData())
}

class ${className}RemoteDataSourceImpl extends I${className}RemoteDataSource {
  final KappaDio dio;

  ${className}RemoteDataSourceImpl(this.dio);

  // TODO: Implement methods using dio
}
''');
  print('✅ DataSource I${className}RemoteDataSource created in module $module.');
}

void _generateWidget(String module, String name) {
  final rc = ReCase(name);
  final fileName = rc.snakeCase;
  final className = rc.pascalCase;
  final dir = 'lib/modules/$module/presentation/widgets';

  Directory(dir).createSync(recursive: true);
  File('$dir/$fileName.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flownest_kappa/kappa.dart';

class $className extends StatelessWidget with KappaSpacing {
  const $className({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text('$className Widget'),
    );
  }
}
''');
  print('✅ Widget $className created in module $module.');
}

void _generateModule(String name) {
  final rc = ReCase(name);
  final moduleName = rc.snakeCase;
  final className = rc.pascalCase;

  print('🚀 Generating module: $moduleName...');

  final directories = [
    'lib/modules/$moduleName/data/datasources',
    'lib/modules/$moduleName/data/repositories',
    'lib/modules/$moduleName/domain/repositories',
    'lib/modules/$moduleName/domain/usecases',
    'lib/modules/$moduleName/presentation/bloc',
    'lib/modules/$moduleName/presentation/pages',
  ];

  for (var dir in directories) {
    Directory(dir).createSync(recursive: true);
  }

  File('lib/modules/$moduleName/${moduleName}_module.dart').writeAsStringSync('''
import 'package:flownest_kappa/kappa.dart';
import 'package:flutter/widgets.dart';

class ${className}Module extends KappaModule {
  @override
  String get name => '$className';

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/$moduleName',
      builder: (context, state) => const Placeholder(),
    ),
  ];

  @override
  void registerDependencies(GetIt sl) {}
}
''');
  print('✅ Module $moduleName generated.');
}

void _generateUseCase(String module, String name) {
  final rc = ReCase(name);
  final fileName = rc.snakeCase;
  final className = rc.pascalCase;
  final dir = 'lib/modules/$module/domain/usecases';
  final testDir = 'test/modules/$module/domain/usecases';

  Directory(dir).createSync(recursive: true);
  Directory(testDir).createSync(recursive: true);

  // File Code
  File('$dir/$fileName.dart').writeAsStringSync('''
import 'package:flownest_kappa/kappa.dart';

class $className extends BaseUseCase<dynamic, NoParams> {
  @override
  Future<Either<Failure, dynamic>> call(NoParams params) async {
    return const Right(null);
  }
}
''');

  // File Test
  File('$testDir/${fileName}_test.dart').writeAsStringSync('''
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flownest_kappa/kappa.dart';
import 'package:kappa_app/modules/$module/domain/usecases/$fileName.dart';

void main() {
  late $className useCase;

  setUp(() {
    useCase = $className();
  });

  test('should return Right(null) when called', () async {
    final result = await useCase(const NoParams());
    expect(result, const Right(null));
  });
}
''');
  print('✅ UseCase $className and its test created.');
}

void _generateBloc(String module, String name) {
  final rc = ReCase(name);
  final fileName = rc.snakeCase;
  final className = rc.pascalCase;
  final dir = 'lib/modules/$module/presentation/bloc';
  final testDir = 'test/modules/$module/presentation/bloc';

  Directory(dir).createSync(recursive: true);
  Directory(testDir).createSync(recursive: true);

  File('$dir/${fileName}_bloc.dart').writeAsStringSync('''
import 'package:flownest_kappa/kappa.dart';
import 'package:equatable/equatable.dart';

abstract class ${className}Event extends Equatable {
  const ${className}Event();
  @override
  List<Object?> get props => [];
}

abstract class ${className}State extends Equatable {
  const ${className}State();
  @override
  List<Object?> get props => [];
}

class ${className}Initial extends ${className}State {}

class ${className}Bloc extends Bloc<${className}Event, ${className}State> {
  ${className}Bloc() : super(${className}Initial()) {
    on<${className}Event>((event, emit) {});
  }
}
''');

  File('$testDir/${fileName}_bloc_test.dart').writeAsStringSync('''
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:kappa_app/modules/$module/presentation/bloc/${fileName}_bloc.dart';

void main() {
  group('${className}Bloc', () {
    blocTest<${className}Bloc, ${className}State>(
      'emits [] when nothing is added',
      build: () => ${className}Bloc(),
      expect: () => [],
    );
  });
}
''');
  print('✅ BLoC ${className}Bloc and its test created.');
}

void _generateRepository(String module, String name) {
  final rc = ReCase(name);
  final fileName = rc.snakeCase;
  final className = rc.pascalCase;
  
  final interfaceDir = 'lib/modules/$module/domain/repositories';
  final implDir = 'lib/modules/$module/data/repositories';
  final testDir = 'test/modules/$module/data/repositories';

  Directory(interfaceDir).createSync(recursive: true);
  Directory(implDir).createSync(recursive: true);
  Directory(testDir).createSync(recursive: true);

  File('$interfaceDir/i_${fileName}_repository.dart').writeAsStringSync('''
import 'package:flownest_kappa/kappa.dart';

abstract class I${className}Repository extends BaseRepository {
  Future<Either<Failure, dynamic>> getData();
}
''');

  File('$implDir/${fileName}_repository_impl.dart').writeAsStringSync('''
import 'package:flownest_kappa/kappa.dart';
import '../../domain/repositories/i_${fileName}_repository.dart';

class ${className}RepositoryImpl extends I${className}Repository {
  @override
  Future<Either<Failure, dynamic>> getData() async {
    return const Right(null);
  }
}
''');

  File('$testDir/${fileName}_repository_impl_test.dart').writeAsStringSync('''
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flownest_kappa/kappa.dart';
import 'package:kappa_app/modules/$module/data/repositories/${fileName}_repository_impl.dart';

void main() {
  late ${className}RepositoryImpl repository;

  setUp(() {
    repository = ${className}RepositoryImpl();
  });

  test('should return Right(null) from getData', () async {
    final result = await repository.getData();
    expect(result, const Right(null));
  });
}
''');
  print('✅ Repository I${className}Repository and its test created.');
}

void _generatePage(String module, String name) {
  final rc = ReCase(name);
  final fileName = rc.snakeCase;
  final className = rc.pascalCase;
  final dir = 'lib/modules/$module/presentation/pages';

  Directory(dir).createSync(recursive: true);
  File('$dir/${fileName}_page.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flownest_kappa/kappa.dart';

class ${className}Page extends StatelessWidget with KappaSpacing {
  const ${className}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KappaAppBar(title: Text('$className')),
      body: const Center(child: Text('$className Page')),
    );
  }
}
''');
  print('✅ Page ${className}Page created in module $module.');
}
