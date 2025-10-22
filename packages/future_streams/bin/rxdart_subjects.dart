import 'dart:async';
import 'package:rxdart/rxdart.dart';

void main() async {
  await subjectsExamples();
}

Future<void> subjectsExamples() async {
  print('\n🎯 RXDART SUBJECTS:');
  
  await behaviorSubject();
  await replaySubject();
  await publishSubject();
  await subjectVsController();
}

Future<void> behaviorSubject() async {
  print('\n1. BehaviorSubject:');
  print('   - Zachowuje ostatnią wartość');
  print('   - Nowi subskrybenci otrzymują ostatnią wartość');
  
  final subject = BehaviorSubject<int>();
  
  // Dodaj wartości
  subject.add(1);
  subject.add(2);
  subject.add(3);
  
  print('   Pierwszy listener (po dodaniu wartości):');
  subject.stream.listen((value) {
    print('     Listener 1: $value');
  });
  
  print('   Drugi listener (otrzyma ostatnią wartość):');
  subject.stream.listen((value) {
    print('     Listener 2: $value');
  });
  
  print('   Dodajemy nową wartość:');
  subject.add(4);
  
  await Future.delayed(Duration(milliseconds: 100));
  subject.close();
}

Future<void> replaySubject() async {
  print('\n2. ReplaySubject:');
  print('   - Zachowuje wszystkie wartości');
  print('   - Nowi subskrybenci otrzymują wszystkie poprzednie wartości');
  
  final subject = ReplaySubject<int>();
  
  // Dodaj wartości
  subject.add(1);
  subject.add(2);
  subject.add(3);
  
  print('   Pierwszy listener:');
  subject.stream.listen((value) {
    print('     Listener 1: $value');
  });
  
  print('   Drugi listener (otrzyma wszystkie wartości):');
  subject.stream.listen((value) {
    print('     Listener 2: $value');
  });
  
  print('   Dodajemy nową wartość:');
  subject.add(4);
  
  await Future.delayed(Duration(milliseconds: 100));
  subject.close();
}

Future<void> publishSubject() async {
  print('\n3. PublishSubject:');
  print('   - Nie zachowuje wartości');
  print('   - Nowi subskrybenci otrzymują tylko nowe wartości');
  
  final subject = PublishSubject<int>();
  
  // Dodaj wartości
  subject.add(1);
  subject.add(2);
  subject.add(3);
  
  print('   Pierwszy listener:');
  subject.stream.listen((value) {
    print('     Listener 1: $value');
  });
  
  print('   Drugi listener (nie otrzyma poprzednich wartości):');
  subject.stream.listen((value) {
    print('     Listener 2: $value');
  });
  
  print('   Dodajemy nową wartość:');
  subject.add(4);
  
  await Future.delayed(Duration(milliseconds: 100));
  subject.close();
}

Future<void> subjectVsController() async {
  print('\n4. Subject vs StreamController:');
  print('   - Pokazuje różnice w zachowaniu');
  
  print('\n   StreamController (single-subscription):');
  final controller = StreamController<int>();
  
  // Pierwszy listener
  controller.stream.listen((value) {
    print('     Controller Listener 1: $value');
  });
  
  controller.add(1);
  controller.add(2);
  
  // Drugi listener - BŁĄD!
  try {
    controller.stream.listen((value) {
      print('     Controller Listener 2: $value');
    });
  } catch (e) {
    print('     Błąd Controller: $e');
  }
  
  controller.close();
  await Future.delayed(Duration(milliseconds: 100));
  
  print('\n   BehaviorSubject (broadcast + cache):');
  final subject = BehaviorSubject<int>();
  
  // Dodaj wartości PRZED listenerami
  subject.add(1);
  subject.add(2);
  
  // Pierwszy listener - otrzyma ostatnią wartość (2)
  subject.stream.listen((value) {
    print('     Subject Listener 1: $value');
  });
  
  // Drugi listener - też otrzyma ostatnią wartość (2)
  subject.stream.listen((value) {
    print('     Subject Listener 2: $value');
  });
  
  // Dodaj nową wartość - oba listenery ją otrzymają
  subject.add(3);
  
  subject.close();
  await Future.delayed(Duration(milliseconds: 100));
  
  print('\n   Kluczowe różnice:');
  print('   - StreamController: single-subscription, brak cache');
  print('   - BehaviorSubject: broadcast, cache ostatniej wartości');
  print('   - BehaviorSubject: nowi listenerzy otrzymują ostatnią wartość');
}
