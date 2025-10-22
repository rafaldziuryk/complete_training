import 'dart:async';

void main() async {
  await streamSubscription();
}

Future<void> streamSubscription() async {
  print('\n8. Subskrypcja streamu - single vs broadcast:');
  
  await singleSubscriptionStream();
  await broadcastStream();
  await streamControllerBroadcast();
  await performanceComparison();
}

Future<void> singleSubscriptionStream() async {
  print('\n   Single-subscription stream:');
  
  Stream<int> singleStream() async* {
    for (int i = 1; i <= 3; i++) {
      print('     Generator: tworzę wartość $i');
      yield i;
    }
  }
  
  final single = singleStream();
  
  print('   Pierwsza subskrypcja:');
  await for (final value in single) {
    print('     Subskrypcja 1: $value');
  }
  
  print('   Druga subskrypcja (błąd!):');
  try {
    await for (final value in single) {
      print('     Subskrypcja 2: $value');
    }
  } catch (e) {
    print('     Błąd: $e');
  }
}

Future<void> broadcastStream() async {
  print('\n   Broadcast stream:');
  
  Stream<int> singleStream() async* {
    for (int i = 1; i <= 3; i++) {
      print('     Generator: tworzę wartość $i');
      yield i;
    }
  }
  
  final broadcast = singleStream().asBroadcastStream();
  
  print('   Pierwsza subskrypcja:');
  await for (final value in broadcast) {
    print('     Subskrypcja 1: $value');
  }
  
  print('   Druga subskrypcja (działa!):');
  await for (final value in broadcast) {
    print('     Subskrypcja 2: $value');
  }
}

Future<void> streamControllerBroadcast() async {
  print('\n   StreamController jako broadcast:');
  
  final controller = StreamController<int>.broadcast();
  
  // Pierwszy listener
  controller.stream.listen((value) {
    print('     Listener 1: $value');
  });
  
  // Drugi listener
  controller.stream.listen((value) {
    print('     Listener 2: $value');
  });
  
  // Dodaj wartości
  controller.add(1);
  controller.add(2);
  controller.add(3);
  
  await Future.delayed(Duration(milliseconds: 100));
  controller.close();
}

Future<void> performanceComparison() async {
  print('\n   Porównanie czasu wykonania:');
  
  Stream<int> singleStream() async* {
    for (int i = 1; i <= 3; i++) {
      print('     Generator: tworzę wartość $i');
      yield i;
    }
  }
  
  // Single stream - każda subskrypcja wykonuje generator
  print('   Single stream (1 subskrypcja):');
  final singleTime = Stopwatch()..start();
  final singleForTime = singleStream();
  await for (final _ in singleForTime) {
    // ignore
  }
  singleTime.stop();
  print('     Czas: ${singleTime.elapsedMilliseconds}ms');
  
  // Broadcast stream - generator wykonuje się raz
  print('   Broadcast stream (2 subskrypcje):');
  final broadcastTime = Stopwatch()..start();
  final broadcastForTime = singleStream().asBroadcastStream();
  await for (final _ in broadcastForTime) {
    // ignore
  }
  await for (final _ in broadcastForTime) {
    // ignore
  }
  broadcastTime.stop();
  print('     Czas: ${broadcastTime.elapsedMilliseconds}ms (generator wykonany raz)');
}
