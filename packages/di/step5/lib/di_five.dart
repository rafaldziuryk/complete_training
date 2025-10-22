import 'package:get_it/get_it.dart';
import 'classes/classes.dart';

class DiInit5 {
  void init() {
    // configureDependencies();
    final getIt = GetIt.instance;
    getIt.registerSingleton(DataSource1());
    getIt.registerSingleton(DataSource2());
    getIt.registerSingleton<Repository1>(
      Repository1Impl(
        dataSource1: getIt.get(),
        dataSource2: getIt.get(),
      ),
    );
    getIt.registerFactoryParam((String param1, param2) => UseCase3(
          repository1: getIt.get(),
          name: param1,
        ));
  }

  void deInit() {
    final getIt = GetIt.instance;
    getIt.reset();
  }
}
