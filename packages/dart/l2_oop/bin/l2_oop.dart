// Basic OOP examples: classes, interfaces, sealed/abstract/mixin/with basics

// Abstract class example
abstract class Animal {
  String name() => 'Animal';
}

// Interface example (using abstract class)
abstract class Flyable {
  void fly();
  String get flightSpeed;
}

// Class implementing interface
class Bird extends Animal implements Flyable {
  @override
  String name() => 'Bird';
  
  @override
  void fly() {
    print('Flying high!');
  }
  
  @override
  String get flightSpeed => '50 km/h';
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

// Sealed class example
sealed class Shape {
  double area();
  double perimeter();
}

class Circle extends Shape {
  final double radius;
  
  Circle(this.radius);
  
  @override
  double area() => 3.14159 * radius * radius;
  
  @override
  double perimeter() => 2 * 3.14159 * radius;
}

class Rectangle extends Shape {
  final double width;
  final double height;
  
  Rectangle(this.width, this.height);
  
  @override
  double area() => width * height;
  
  @override
  double perimeter() => 2 * (width + height);
}

class Triangle extends Shape {
  final double base;
  final double height;
  final double side1;
  final double side2;
  
  Triangle(this.base, this.height, this.side1, this.side2);
  
  @override
  double area() => 0.5 * base * height;
  
  @override
  double perimeter() => base + side1 + side2;
}

void main() {
  print('=== Abstract Classes ===');
  final dogA = DogA(age: 3);
  print('DogA name: ${dogA.name()}, map: ${dogA.toMap()}');

  print('\n=== Interfaces ===');
  final bird = Bird();
  print('Bird name: ${bird.name()}');
  bird.fly();
  print('Bird flight speed: ${bird.flightSpeed}');

  print('\n=== Sealed Classes ===');
  final shapes = <Shape>[
    Circle(5.0),
    Rectangle(4.0, 6.0),
    Triangle(3.0, 4.0, 5.0, 5.0),
  ];
  
  for (final shape in shapes) {
    print('${shape.runtimeType}: area=${shape.area().toStringAsFixed(2)}, perimeter=${shape.perimeter().toStringAsFixed(2)}');
  }

  print('\n=== Pattern Matching with Sealed Classes ===');
  for (final shape in shapes) {
    switch (shape) {
      case Circle(radius: final r):
        print('Circle with radius $r');
      case Rectangle(width: final w, height: final h):
        print('Rectangle ${w}x$h');
      case Triangle(base: final b, height: final h):
        print('Triangle with base $b and height $h');
    }
  }

  print('\n=== Mixins and Multiple Inheritance ===');
  final dogD1 = DogD1(age: 5);
  final dogD2 = DogD2(age: 6);
  final dogE = DogE(age: 7);

  print('DogD1 name: ${dogD1.name()}, map: ${dogD1.toMap()}');
  print('DogD2 name: ${dogD2.name()}, map: ${dogD2.toMap()}');
  print('DogE name: ${dogE.name()}, map: ${dogE.toMap()}');

  print('\n=== Interface Implementation ===');
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
