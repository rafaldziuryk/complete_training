import 'dart:async';

void main() async {
  await streamConstructors();
}

Future<void> streamConstructors() async {
  print('\n7. Różne konstruktory Stream:');
  
  await streamPeriodic();
  await streamFromIterable();
  await streamFromFuture();
  await streamFromFutures();
  await streamValue();
  await streamError();
  await streamEmpty();
  await streamMulti();
}

Future<void> streamPeriodic() async {
  print('\n   Stream.periodic (co 500ms):');
  
  final periodicStream = Stream.periodic(
    Duration(milliseconds: 500),
    (count) => count,
  ).take(3);
  
  await for (final value in periodicStream) {
    print('     Wartość: $value');
  }
}

Future<void> streamFromIterable() async {
  print('\n   Stream.fromIterable:');
  
  final fruits = ['jabłko', 'banan', 'pomarańcza'];
  final fruitStream = Stream.fromIterable(fruits);
  
  await for (final fruit in fruitStream) {
    print('     Owoc: $fruit');
  }
}

Future<void> streamFromFuture() async {
  print('\n   Stream.fromFuture:');
  
  Future<String> fetchData() async {
    await Future.delayed(Duration(milliseconds: 100));
    return 'Wartość z Future';
  }
  
  final futureStream = Stream.fromFuture(fetchData());
  
  await for (final value in futureStream) {
    print('     $value');
  }
}

Future<void> streamFromFutures() async {
  print('\n   Stream.fromFutures:');
  
  Future<String> fetchItem(int id) async {
    await Future.delayed(Duration(milliseconds: 100));
    return 'Element $id';
  }
  
  final futures = [
    fetchItem(1),
    fetchItem(2),
    fetchItem(3),
  ];
  
  final futuresStream = Stream.fromFutures(futures);
  
  await for (final value in futuresStream) {
    print('     $value');
  }
}

Future<void> streamValue() async {
  print('\n   Stream.value:');
  
  final valueStream = Stream.value('Pojedyncza wartość');
  
  await for (final value in valueStream) {
    print('     $value');
  }
}

Future<void> streamError() async {
  print('\n   Stream.error:');
  
  final errorStream = Stream.error('Błąd w konstruktorze');
  
  try {
    await for (final value in errorStream) {
      print('     $value');
    }
  } catch (e) {
    print('     Błąd: $e');
  }
}

Future<void> streamEmpty() async {
  print('\n   Stream.empty:');
  
  final emptyStream = Stream.empty();
  
  await for (final value in emptyStream) {
    print('     $value');
  }
  print('     Pusty stream - brak wartości');
}

Future<void> streamMulti() async {
  print('\n   Stream.multi:');
  
  final multiStream = Stream.multi((controller) async {
    await Future.delayed(Duration(milliseconds: 100));
    controller.add('Pierwsza');
    await Future.delayed(Duration(milliseconds: 100));
    controller.add('Druga');
    await Future.delayed(Duration(milliseconds: 100));
    controller.add('Trzecia');
    controller.close();
  });
  
  await for (final value in multiStream) {
    print('     $value');
  }
}
