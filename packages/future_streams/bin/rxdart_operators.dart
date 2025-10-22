import 'dart:async';
import 'package:rxdart/rxdart.dart';

void main() async {
  await operatorsExamples();
}

Future<void> operatorsExamples() async {
  print('\n🔧 RXDART OPERATORS:');
  
  await mergeZip();
  await throttleDebounce();
  await bufferWindow();
  await distinctSkip();
  await scanReduce();
  await switchMapFlatMap();
}

Future<void> mergeZip() async {
  print('\n1. Merge i Zip:');
  
  // Merge - łączy wiele streamów w jeden
  print('   Merge - łączy streamy:');
  final stream1 = Stream.periodic(Duration(milliseconds: 200), (i) => 'A$i').take(3);
  final stream2 = Stream.periodic(Duration(milliseconds: 300), (i) => 'B$i').take(3);
  final stream3 = Stream.periodic(Duration(milliseconds: 400), (i) => 'C$i').take(3);
  
  final merged = Rx.merge([stream1, stream2, stream3]);
  await for (final value in merged) {
    print('     $value');
  }
  
  // Zip - łączy wartości z różnych streamów
  print('\n   Zip - łączy wartości:');
  final numbers = Stream.periodic(Duration(milliseconds: 200), (i) => i).take(3);
  final letters = Stream.periodic(Duration(milliseconds: 300), (i) => String.fromCharCode(65 + i)).take(3);
  
  final zipped = Rx.zip2(numbers, letters, (int n, String l) => '$n$l');
  await for (final value in zipped) {
    print('     $value');
  }
}

Future<void> throttleDebounce() async {
  print('\n2. Throttle i Debounce:');
  
  // Throttle - ogranicza częstotliwość emisji
  print('   Throttle (co 500ms):');
  final throttleSubject = PublishSubject<String>();
  
  throttleSubject
      .throttleTime(Duration(milliseconds: 500))
      .listen((value) {
    print('     Throttled: $value');
  });
  
  // Symuluj szybkie kliknięcia
  for (int i = 1; i <= 10; i++) {
    throttleSubject.add('Click $i');
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  await Future.delayed(Duration(milliseconds: 1000));
  throttleSubject.close();
  
  // Debounce - czeka na koniec serii zdarzeń
  print('\n   Debounce (500ms po ostatnim zdarzeniu):');
  final debounceSubject = PublishSubject<String>();
  
  debounceSubject
      .debounceTime(Duration(milliseconds: 500))
      .listen((value) {
    print('     Debounced: $value');
  });
  
  // Symuluj wpisywanie w polu tekstowym
  for (int i = 1; i <= 5; i++) {
    debounceSubject.add('Search $i');
    await Future.delayed(Duration(milliseconds: 200));
  }
  
  await Future.delayed(Duration(milliseconds: 1000));
  debounceSubject.close();
}

Future<void> bufferWindow() async {
  print('\n3. Buffer i Window:');
  
  // Buffer - gromadzi wartości w grupy
  print('   Buffer (co 3 wartości):');
  final bufferStream = Stream.periodic(Duration(milliseconds: 200), (i) => i).take(10);
  
  bufferStream
      .bufferCount(3)
      .listen((List<int> values) {
    print('     Buffer: $values');
  });
  
  await Future.delayed(Duration(milliseconds: 2500));
  
  // Window - dzieli stream na okna czasowe
  print('\n   Window (co 1 sekundę):');
  final windowStream = Stream.periodic(Duration(milliseconds: 200), (i) => i).take(15);
  
  windowStream
      .bufferTime(Duration(seconds: 1))
      .listen((List<int> values) {
    print('     Window: $values');
  });
  
  await Future.delayed(Duration(milliseconds: 2000));
}

Future<void> distinctSkip() async {
  print('\n4. Distinct i Skip:');
  
  // Distinct - usuwa duplikaty
  print('   Distinct - usuwa duplikaty:');
  final distinctStream = Stream.fromIterable([1, 2, 2, 3, 3, 3, 4, 5, 5]);
  
  distinctStream
      .distinct()
      .listen((value) {
    print('     $value');
  });
  
  await Future.delayed(Duration(milliseconds: 100));
  
  // SkipWhile - pomija wartości spełniające warunek
  print('\n   SkipWhile - pomija wartości < 3:');
  final skipStream = Stream.fromIterable([1, 2, 3, 4, 5, 6]);
  
  skipStream
      .skipWhile((value) => value < 3)
      .listen((value) {
    print('     $value');
  });
  
  await Future.delayed(Duration(milliseconds: 100));
}

Future<void> scanReduce() async {
  print('\n5. Scan i Reduce:');
  
  // Scan - akumuluje wartości
  print('   Scan - akumuluje wartości:');
  final scanStream = Stream.fromIterable([1, 2, 3, 4, 5]);
  
  scanStream
      .scan((int acc, int value, int index) => acc + value, 0)
      .listen((value) {
    print('     Suma: $value');
  });
  
  await Future.delayed(Duration(milliseconds: 100));
  
  // Reduce - redukuje stream do jednej wartości
  print('\n   Reduce - suma wszystkich wartości:');
  final reduceStream = Stream.fromIterable([1, 2, 3, 4, 5]);
  
  final result = await reduceStream.reduce((int acc, int value) => acc + value);
  print('     Wynik: $result');
}

Future<void> switchMapFlatMap() async {
  print('\n6. SwitchMap i FlatMap:');
  
  // SwitchMap - przełącza na nowy stream, anuluje poprzedni
  print('   SwitchMap - przełącza streamy:');
  final switchSubject = PublishSubject<int>();
  
  switchSubject
      .switchMap((int value) => Stream.periodic(
          Duration(milliseconds: 200), 
          (i) => 'Switch $value-$i'
      ).take(3))
      .listen((value) {
    print('     $value');
  });
  
  switchSubject.add(1);
  await Future.delayed(Duration(milliseconds: 300));
  switchSubject.add(2); // Anuluje poprzedni stream
  await Future.delayed(Duration(milliseconds: 500));
  switchSubject.close();
  
  // FlatMap - łączy wszystkie streamy
  print('\n   FlatMap - łączy streamy:');
  final flatMapStream = Stream.fromIterable([1, 2, 3]);
  
  flatMapStream
      .flatMap((int value) => Stream.periodic(
          Duration(milliseconds: 100), 
          (i) => 'Flat $value-$i'
      ).take(2))
      .listen((value) {
    print('     $value');
  });
  
  await Future.delayed(Duration(milliseconds: 800));
}
