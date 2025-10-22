import 'package:di_step1/classes/classes.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class DiInit1 {
  void init() {

    // Register DataSources as singletons
    sl.registerSingleton<DataSource1>(DataSource1());
    sl.registerSingleton<DataSource2>(DataSource2());
    
    // Register Repository with dependencies
    sl.registerSingleton<Repository1Impl>(Repository1Impl(
      dataSource1: sl.get<DataSource1>(),
      dataSource2: sl.get<DataSource2>(),
    ));
  }

  void deInit() {
    final getIt = GetIt.instance;
    getIt.reset();
  }
}
