// ========== FUTURE UTILITIES ==========

/// Symuluje pobieranie danych z API
Future<String> fetchData(String endpoint) async {
  await Future.delayed(Duration(milliseconds: 500));
  return 'Dane z $endpoint';
}

/// Symuluje operację która może się nie powieść
Future<int> riskyOperation(int value) async {
  await Future.delayed(Duration(milliseconds: 200));
  if (value < 0) throw Exception('Wartość nie może być ujemna');
  return value * 2;
}

/// Symuluje długą operację
Future<String> longOperation() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Operacja zakończona';
}

// ========== STREAM UTILITIES ==========

/// Tworzy stream liczb
Stream<int> numberStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 100));
    yield i;
  }
}

/// Tworzy stream z błędem
Stream<String> errorStream() async* {
  yield 'Pierwsza wiadomość';
  yield 'Druga wiadomość';
  throw Exception('Błąd w streamie');
}

/// Tworzy stream z transformacją
Stream<String> transformedStream() async* {
  for (int i = 1; i <= 5; i++) {
    yield 'Element $i';
  }
}

// ========== HELPER FUNCTIONS ==========

/// Wyświetla czas wykonania operacji
void logTime(String operation, Duration duration) {
  print('$operation: ${duration.inMilliseconds}ms');
}

/// Sprawdza czy wartość jest parzysta
bool isEven(int number) => number % 2 == 0;

/// Podwaja wartość
int doubleValue(int value) => value * 2;