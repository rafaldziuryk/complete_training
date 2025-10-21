import 'package:di_step1/classes/classes.dart';
import 'package:get_it/get_it.dart';

class DiInit1 {
  void init() {
    final getIt = GetIt.instance;
    
    // Register DataSources as singletons
    getIt.registerSingleton<DataSource1>(DataSource1());
    getIt.registerSingleton<DataSource2>(DataSource2());
    
    // Register Repository with dependencies
    getIt.registerSingleton<Repository1Impl>(Repository1Impl(
      dataSource1: getIt.get<DataSource1>(),
      dataSource2: getIt.get<DataSource2>(),
    ));
  }

  void deInit() {
    final getIt = GetIt.instance;
    getIt.reset();
  }
}
