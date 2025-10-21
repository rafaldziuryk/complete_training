// Classes for Step 2 - GetIt with Interfaces

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

class Repository1Impl extends Repository1 {
  final DataSource1 dataSource1;
  final DataSource2 dataSource2;

  Repository1Impl({
    required this.dataSource1,
    required this.dataSource2,
  });

  @override
  void hello() {
    print('Hello Repository1Impl $hashCode');
    dataSource1.hello();
    dataSource2.hello();
  }
}

class DataSource1 {
  void hello() => print('Hello DataSource1 $hashCode');
}

class DataSource2 {
  void hello() => print('Hello DataSource2 $hashCode');
}

abstract class Repository2 {
  void hello() => print('Hello Repository2 $hashCode');
}

class Repository2DBImplementation extends Repository2 {
  @override
  void hello() => print('Hello Repository2DBImplementation $hashCode');
}

class Repository2SPImplementation extends Repository2 {
  @override
  void hello() => print('Hello Repository2SPImplementation $hashCode');
}

class UseCase2 {
  final Repository2 dbRepository;
  final Repository2 spRepository;

  const UseCase2({
    required this.dbRepository,
    required this.spRepository,
  });

  void hello() {
    print('Hello UseCase2 $hashCode');
    dbRepository.hello();
    spRepository.hello();
  }
}

class UseCase3 {
  final Repository1 repository1;
  final String name;

  const UseCase3({
    required this.repository1,
    required this.name,
  });

  void hello() {
    print('Hello UseCase3 $hashCode and param: $name');
  }
}