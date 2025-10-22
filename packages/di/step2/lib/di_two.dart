import 'package:di_step2/classes/classes.dart';
import 'package:get_it/get_it.dart';

class DiInit2 {
  void init() {
    final getIt = GetIt.instance;
    
    // Register DataSources as singletons
    getIt.registerSingleton<DataSource1>(DataSource1());
    getIt.registerSingleton<DataSource2>(DataSource2());
    
    // Register Repository interface with implementation
    getIt.registerSingleton<Repository1>(Repository1Impl(
      dataSource1: getIt.get<DataSource1>(),
      dataSource2: getIt.get<DataSource2>(),
    ));
  }

  void deInit() {
    final getIt = GetIt.instance;
    getIt.reset();
  }
}
