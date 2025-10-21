import 'package:get_it/get_it.dart';
import 'classes/classes.dart';

class DiInit3 {
  void init() {
    // configureDependencies();
    final getIt = GetIt.instance;
    getIt.registerSingleton(DataSource1());
    getIt.registerSingleton(DataSource2());
    getIt.registerFactory<Repository1>(() => Repository1Impl(
          dataSource1: getIt.get(),
          dataSource2: getIt.get(),
        ));
  }

  void deInit() {
    final getIt = GetIt.instance;
    getIt.reset();
  }
}
