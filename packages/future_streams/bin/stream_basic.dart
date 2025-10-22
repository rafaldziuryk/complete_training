import 'dart:async';

void main() async {
  await streamBasic();
  await streamWithError();
  await streamTransform();
  await streamController();
  await streamAsyncMap();
  await streamTakeSkip();
}

Future<void> streamBasic() async {
  print('\n1. Podstawowy Stream:');
  
  Stream<int> numberStream() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(Duration(milliseconds: 200));
      yield i;
    }
  }
  
  await for (final number in numberStream()) {
    print('   Liczba: $number');
  }
}

Future<void> streamWithError() async {
  print('\n2. Stream z błędem:');
  
  Stream<int> errorStream() async* {
    for (int i = 1; i <= 5; i++) {
      if (i == 3) {
        throw Exception('Błąd na pozycji $i');
      }
      yield i;
    }
  }
  
  try {
    await for (final number in errorStream()) {
      print('   Liczba: $number');
    }
  } catch (e) {
    print('   Błąd: $e');
  }
}

Future<void> streamTransform() async {
  print('\n3. Stream.transform:');
  
  Stream<int> numberStream() async* {
    for (int i = 1; i <= 5; i++) {
      yield i;
    }
  }
  
  final transformedStream = numberStream().map((number) => number * number);
  
  await for (final square in transformedStream) {
    print('   Kwadrat: $square');
  }
}

Future<void> streamController() async {
  print('\n4. StreamController:');
  
  final controller = StreamController<String>();
  
  controller.stream.listen(
    (data) => print('   Otrzymano: $data'),
    onError: (error) => print('   Błąd: $error'),
    onDone: () => print('   Stream zakończony'),
  );
  
  controller.add('Pierwsza wiadomość');
  controller.add('Druga wiadomość');
  controller.addError('Błąd wiadomości');
  controller.add('Trzecia wiadomość');
  controller.close();
  
  await Future.delayed(Duration(milliseconds: 100));
}

Future<void> streamAsyncMap() async {
  print('\n5. Stream.asyncMap:');
  
  Stream<int> numberStream() async* {
    for (int i = 1; i <= 3; i++) {
      yield i;
    }
  }
  
  final processedStream = numberStream().asyncMap((number) async {
    await Future.delayed(Duration(milliseconds: 300));
    return 'Przetworzono: $number';
  });
  
  await for (final result in processedStream) {
    print('   $result');
  }
}

Future<void> streamTakeSkip() async {
  print('\n6. Stream.take i skip:');
  
  Stream<int> numberStream() async* {
    for (int i = 1; i <= 10; i++) {
      yield i;
    }
  }
  
  print('   Pierwsze 3 liczby:');
  await for (final number in numberStream().take(3)) {
    print('     $number');
  }
  
  print('   Pomijając pierwsze 2, następne 3:');
  await for (final number in numberStream().skip(2).take(3)) {
    print('     $number');
  }
}
