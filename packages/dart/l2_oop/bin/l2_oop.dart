// Basic OOP examples: classes, interfaces, sealed/abstract/mixin/with basics

abstract class Animal {
  String name() => 'Animal';
}

class Mammal {
  String name() => 'Mammal';

  final int age;

  const Mammal({
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'age': age,
    };
  }

  factory Mammal.fromMap(Map<String, dynamic> map) {
    return Mammal(
      age: map['age'] as int,
    );
  }
}

mixin class Doggy {
  String name() => 'Doggy';
}

mixin DogMixin on Mammal {
  @override
  String name() => 'DogMixin';

  @override
  Map<String, dynamic> toMap() {
    return {
      'age': age,
    };
  }
}

class DogA extends Mammal implements Animal {
  DogA({required super.age});
}

class DogB extends Animal implements Mammal {
  @override
  int get age => 10;

  @override
  Map<String, dynamic> toMap() {
    return {
      'age': age,
    };
  }
}

class DogC with Doggy implements Mammal {
  @override
  int get age => throw UnimplementedError();

  @override
  Map<String, dynamic> toMap() {
    return {
      'age': age,
    };
  }
}

class DogD1 extends Mammal with Doggy, DogMixin {
  DogD1({required super.age});
}

class DogD2 extends Mammal with DogMixin, Doggy {
  DogD2({required super.age});
}

class DogE extends Mammal with DogMixin implements Doggy {
  DogE({required super.age});
}

void main() {
  final dogA = DogA(age: 3);
  final dogD1 = DogD1(age: 5);
  final dogD2 = DogD2(age: 6);
  final dogE = DogE(age: 7);

  print('DogA name: ${dogA.name()}, map: ${dogA.toMap()}');
  print('DogD1 name: ${dogD1.name()}, map: ${dogD1.toMap()}');
  print('DogD2 name: ${dogD2.name()}, map: ${dogD2.toMap()}');
  print('DogE name: ${dogE.name()}, map: ${dogE.toMap()}');

  // The following demonstrate interface-style classes lacking concrete fields
  final dogB = DogB();
  print('DogB age: ${dogB.age}, map: ${dogB.toMap()}');

  // DogC throws for age (unimplemented)
  try {
    final dogC = DogC();
    print('DogC age: ${dogC.age}');
  } catch (e) {
    print('DogC age throws: $e');
  }
}
