import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sof_task/core/di/injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'initGetIt',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.initGetIt();
