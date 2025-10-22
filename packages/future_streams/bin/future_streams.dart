import 'future_examples.dart';
import 'stream_basic.dart';
import 'stream_constructors.dart';
import 'stream_subscription.dart';
import 'rxdart_subjects.dart';
import 'rxdart_operators.dart';
import 'rxdart_advanced.dart';

void main() async {
  print('=== FUTURE I STREAM PRZYKŁADY ===');
  
  // Future przykłady
  await futureExamples();
  
  print('\n==================================================');
  
  // Stream przykłady
  await streamExamples();
}

Future<void> streamExamples() async {
  print('\n🌊 STREAM PRZYKŁADY:');
  
  // 1. Podstawowy Stream
  await streamBasic();
  
  // 2. Stream z błędem
  await streamWithError();
  
  // 3. Stream.transform
  await streamTransform();
  
  // 4. StreamController
  await streamController();
  
  // 5. Stream.asyncMap
  await streamAsyncMap();
  
  // 6. Stream.take i skip
  await streamTakeSkip();
  
  // 7. Różne konstruktory Stream
  await streamConstructors();
  
  // 8. Subskrypcja streamu - single vs broadcast
  await streamSubscription();
  
  print('\n==================================================');
  
  // RxDart przykłady
  await rxdartExamples();
}

Future<void> rxdartExamples() async {
  print('\n🎯 RXDART PRZYKŁADY:');
  
  // 1. Subjects
  await subjectsExamples();
  
  // 2. Operators
  await operatorsExamples();
  
  // 3. Advanced
  await advancedExamples();
}