import 'dart:async';
import 'package:rxdart/rxdart.dart';

void main() async {
  await advancedExamples();
}

Future<void> advancedExamples() async {
  print('\n🚀 RXDART ADVANCED:');
  
  await combineLatest();
  await withLatestFrom();
  await startWith();
  await retryWhen();
  await backpressure();
}

Future<void> combineLatest() async {
  print('\n1. CombineLatest:');
  print('   - Łączy najnowsze wartości z wielu streamów');
  print('   - Emituje gdy którykolwiek stream emituje nową wartość');
  
  final stream1 = Stream.periodic(Duration(milliseconds: 300), (i) => 'A$i').take(4);
  final stream2 = Stream.periodic(Duration(milliseconds: 400), (i) => 'B$i').take(4);
  final stream3 = Stream.periodic(Duration(milliseconds: 500), (i) => 'C$i').take(4);
  
  Rx.combineLatest3(stream1, stream2, stream3, (String a, String b, String c) => '$a-$b-$c')
      .listen((value) {
    print('     $value');
  });
  
  await Future.delayed(Duration(milliseconds: 2000));
}

Future<void> withLatestFrom() async {
  print('\n2. WithLatestFrom:');
  print('   - Łączy wartości z głównego streamu z najnowszymi z innych');
  
  final mainStream = Stream.periodic(Duration(milliseconds: 200), (i) => 'Main$i').take(5);
  final otherStream = Stream.periodic(Duration(milliseconds: 300), (i) => 'Other$i').take(4);
  
  mainStream
      .withLatestFrom(otherStream, (String main, String other) => '$main + $other')
      .listen((value) {
    print('     $value');
  });
  
  await Future.delayed(Duration(milliseconds: 1500));
}

Future<void> startWith() async {
  print('\n3. StartWith:');
  print('   - Rozpoczyna stream z określoną wartością');
  
  final stream = Stream.periodic(Duration(milliseconds: 200), (i) => i).take(3);
  
  stream
      .startWith(-1)
      .listen((value) {
    print('     $value');
  });
  
  await Future.delayed(Duration(milliseconds: 800));
}

Future<void> retryWhen() async {
  print('\n4. RetryWhen:');
  print('   - Ponawia operację w określonych warunkach');
  
  int attempt = 0;
  
  // Tworzymy nowy stream za każdym razem
  Stream<String> createStream() {
    attempt++;
    if (attempt < 3) {
      return Stream.error(Exception('Błąd $attempt'));
    }
    return Stream.value('Sukces!');
  }
  
  Rx.retry(createStream, 2)
      .listen(
        (value) => print('     $value'),
        onError: (error) => print('     Błąd: $error'),
      );
  
  await Future.delayed(Duration(milliseconds: 1000));
}

Future<void> backpressure() async {
  print('\n6. Backpressure:');
  print('   - Kontroluje przepływ danych gdy producent jest szybszy od konsumenta');
  
  // Symuluj szybki producent
  final fastProducer1 = Stream.periodic(Duration(milliseconds: 50), (i) => i).take(10);
  final fastProducer2 = Stream.periodic(Duration(milliseconds: 50), (i) => i).take(10);
  
  print('   Bez backpressure (może powodować problemy):');
  final subscription = fastProducer1.listen((value) {
    print('     $value');
  });
  
  // Symuluj wolny konsument
  await Future.delayed(Duration(milliseconds: 500));
  subscription.pause();
  
  print('\n   Z backpressure (throttle co 200ms):');
  fastProducer2
      .throttleTime(Duration(milliseconds: 200))
      .listen((value) {
    print('     Sampled: $value');
  });
  
  await Future.delayed(Duration(milliseconds: 1000));
}
