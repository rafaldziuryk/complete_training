import 'package:get_it/get_it.dart';

import 'classes/classes.dart';

class DiInit4 {
  void init() {
    // configureDependencies();
    final getIt = GetIt.instance;
    getIt.registerSingleton<Repository2>(Repository2DBImplementation(), instanceName: 'db');
    getIt.registerSingleton<Repository2>(Repository2SPImplementation(), instanceName: 'sp');
    getIt.registerFactory<UseCase2>(() => UseCase2(
          dbRepository: getIt.get(instanceName: 'db'),
          spRepository: getIt.get(instanceName: 'sp'),
        ));
  }

  void deInit() {
    final getIt = GetIt.instance;
    getIt.reset();
  }
}
