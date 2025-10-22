import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'classes.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(getIt);

class UseCase1 {
  final Repository1 repository1;

  const UseCase1({
    required this.repository1,
  });

  void hello() => print('Hello UseCase1 $hashCode');
}

abstract class Repository1 {
  void hello() => print('Hello Repository1 $hashCode');
}

@Injectable(as: Repository1)
class Repository1Impl extends Repository1 {
  final DataSource1 dataSource1;
  final DataSource2 dataSource2;

  Repository1Impl({
    required this.dataSource1,
    required this.dataSource2,
  });

  void hello() {
    print('Hello Repository1Impl $hashCode');
    dataSource1.hello();
    dataSource2.hello();
  }
}

@singleton
class DataSource1 {
  void hello() => print('Hello DataSource1 $hashCode');
}

@singleton
class DataSource2 {
  void hello() => print('Hello DataSource2 $hashCode');
}

abstract class Repository2 {
  void hello() => print('Hello Repository2 $hashCode');
}

@Named('db')
@Singleton(as: Repository2)
class Repository2DBImplementation extends Repository2 {
  void hello() => print('Hello Repository2DBImplementation $hashCode');
}

@Named('sp')
@Singleton(as: Repository2)
class Repository2SPImplementation extends Repository2 {
  void hello() => print('Hello Repository2SPImplementation $hashCode');
}

@injectable
class UseCase2 {
  final Repository2 dbRepository;
  final Repository2 spRepository;

  const UseCase2({
    @Named('db') required this.dbRepository,
    @Named('sp') required this.spRepository,
  });

  void hello() {
    print('Hello UseCase2 $hashCode');
    dbRepository.hello();
    spRepository.hello();
  }
}

@injectable
class UseCase3 {
  final Repository1 repository1;
  final String name;

  const UseCase3({
    required this.repository1,
    @factoryParam required this.name,
  });

  void hello() {
    print('Hello UseCase2 $hashCode and param: $name');
  }
}
