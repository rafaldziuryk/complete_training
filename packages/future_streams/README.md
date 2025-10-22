# Future i Stream Przykłady

Projekt demonstrujący podstawowe funkcjonalności Future i Stream w Dart.

## Opis

Ten projekt zawiera zwięzłe przykłady pokazujące jak działają:
- **Future** - asynchroniczne operacje zwracające pojedynczą wartość
- **Stream** - asynchroniczne sekwencje danych

## Struktura

```
lib/
└── future_streams.dart    # Utility functions
bin/
└── future_streams.dart    # Główne przykłady
```

## Jak uruchomić

```bash
cd packages/future_streams
dart run bin/future_streams.dart
```

## Struktura plików

```
bin/
├── future_streams.dart          # Główny plik - uruchamia wszystkie przykłady
├── future_examples.dart         # Przykłady Future (5 przykładów)
├── stream_basic.dart            # Podstawowe przykłady Stream (6 przykładów)
├── stream_constructors.dart     # Konstruktory Stream (8 przykładów)
├── stream_subscription.dart     # Subskrypcja Stream - single vs broadcast
├── rxdart_subjects.dart         # RxDart Subjects (4 przykłady)
├── rxdart_operators.dart        # RxDart Operators (6 przykładów)
└── rxdart_advanced.dart         # RxDart Advanced (6 przykładów)
```

### Uruchomienie pojedynczych sekcji

```bash
# Tylko przykłady Future
dart run bin/future_examples.dart

# Tylko podstawowe Stream
dart run bin/stream_basic.dart

# Tylko konstruktory Stream
dart run bin/stream_constructors.dart

# Tylko subskrypcja Stream
dart run bin/stream_subscription.dart

# Tylko RxDart Subjects
dart run bin/rxdart_subjects.dart

# Tylko RxDart Operators
dart run bin/rxdart_operators.dart

# Tylko RxDart Advanced
dart run bin/rxdart_advanced.dart
```

## Przykłady Future

### 1. Podstawowy Future
```dart
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dane pobrane!';
}

final result = await fetchData();
print(result); // Dane pobrane!
```

### 2. Future z błędem
```dart
Future<String> fetchWithError() async {
  throw Exception('Błąd połączenia!');
}

try {
  await fetchWithError();
} catch (e) {
  print('Błąd: $e');
}
```

### 3. Future.wait - równoległe wykonanie
```dart
Future<String> fetchUser(int id) async {
  await Future.delayed(Duration(milliseconds: 300));
  return 'Użytkownik $id';
}

final results = await Future.wait([
  fetchUser(1),
  fetchUser(2),
  fetchUser(3),
]);
print(results); // [Użytkownik 1, Użytkownik 2, Użytkownik 3]
```

### 4. Future.timeout
```dart
Future<String> slowOperation() async {
  await Future.delayed(Duration(seconds: 3));
  return 'Zakończono!';
}

try {
  final result = await slowOperation().timeout(Duration(seconds: 2));
  print(result);
} catch (e) {
  print('Timeout: $e');
}
```

### 5. Future.then i catchError
```dart
Future<int> divide(int a, int b) async {
  if (b == 0) throw Exception('Dzielenie przez zero!');
  return a ~/ b;
}

divide(10, 2)
  .then((result) => print('Wynik: $result'))
  .catchError((error) => print('Błąd: $error'));
```

## Przykłady Stream

### 1. Podstawowy Stream
```dart
Stream<int> countStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(milliseconds: 200));
    yield i;
  }
}

await for (final number in countStream()) {
  print('Liczba: $number');
}
```

### 2. Stream z błędem
```dart
Stream<int> errorStream() async* {
  for (int i = 1; i <= 3; i++) {
    if (i == 2) throw Exception('Błąd na pozycji $i');
    yield i;
  }
}

try {
  await for (final number in errorStream()) {
    print('Liczba: $number');
  }
} catch (e) {
  print('Błąd: $e');
}
```

### 3. Stream.transform
```dart
Stream<int> numbers() async* {
  for (int i = 1; i <= 5; i++) {
    yield i;
  }
}

await for (final square in numbers().map((n) => n * n)) {
  print('Kwadrat: $square');
}
```

### 4. StreamController
```dart
final controller = StreamController<String>();

controller.stream.listen(
  (data) => print('Otrzymano: $data'),
  onError: (error) => print('Błąd: $error'),
  onDone: () => print('Stream zakończony'),
);

controller.add('Wiadomość');
controller.close();
```

### 5. Stream.asyncMap
```dart
Stream<int> numbers() async* {
  for (int i = 1; i <= 3; i++) {
    yield i;
  }
}

Future<String> processNumber(int n) async {
  await Future.delayed(Duration(milliseconds: 100));
  return 'Przetworzono: $n';
}

await for (final result in numbers().asyncMap(processNumber)) {
  print(result);
}
```

### 6. Stream.take i skip
```dart
Stream<int> numbers() async* {
  for (int i = 1; i <= 10; i++) {
    yield i;
  }
}

// Pierwsze 3 liczby
await for (final number in numbers().take(3)) {
  print(number);
}

// Pomijając pierwsze 2, następne 3
await for (final number in numbers().skip(2).take(3)) {
  print(number);
}
```

### 7. Różne konstruktory Stream

#### Stream.periodic - interwał czasowy
```dart
final periodicStream = Stream.periodic(
  Duration(milliseconds: 500), 
  (count) => count
);
await for (final value in periodicStream.take(3)) {
  print('Wartość: $value');
}
```

#### Stream.fromIterable - z listy
```dart
await for (final fruit in Stream.fromIterable(['jabłko', 'banan', 'pomarańcza'])) {
  print('Owoc: $fruit');
}
```

#### Stream.fromFuture - z Future
```dart
Future<String> futureValue() async {
  await Future.delayed(Duration(milliseconds: 100));
  return 'Wartość z Future';
}

await for (final value in Stream.fromFuture(futureValue())) {
  print(value);
}
```

#### Stream.fromFutures - z listy Future
```dart
Future<String> fetchItem(int id) async {
  await Future.delayed(Duration(milliseconds: 50));
  return 'Element $id';
}

await for (final item in Stream.fromFutures([
  fetchItem(1),
  fetchItem(2),
  fetchItem(3),
])) {
  print(item);
}
```

#### Stream.value - pojedyncza wartość
```dart
await for (final value in Stream.value('Pojedyncza wartość')) {
  print(value);
}
```

#### Stream.error - stream z błędem
```dart
try {
  await for (final value in Stream.error('Błąd w konstruktorze')) {
    print(value);
  }
} catch (e) {
  print('Błąd: $e');
}
```

#### Stream.empty - pusty stream
```dart
bool hasValues = false;
await for (final value in Stream.empty()) {
  hasValues = true;
  print(value);
}
if (!hasValues) {
  print('Pusty stream - brak wartości');
}
```

#### Stream.multi - niestandardowy konstruktor
```dart
final multiStream = Stream.multi((controller) async {
  controller.add('Pierwsza');
  await Future.delayed(Duration(milliseconds: 100));
  controller.add('Druga');
  controller.close();
});

await for (final value in multiStream) {
  print(value);
}
```

### 8. Subskrypcja streamu - single vs broadcast

#### Single-subscription stream
```dart
Stream<int> singleStream() async* {
  for (int i = 1; i <= 3; i++) {
    print('Generator: tworzę wartość $i');
    yield i;
  }
}

final single = singleStream();

// Pierwsza subskrypcja - działa
await for (final value in single) {
  print('Subskrypcja 1: $value');
}

// Druga subskrypcja - BŁĄD!
try {
  await for (final value in single) {
    print('Subskrypcja 2: $value');
  }
} catch (e) {
  print('Błąd: $e');
}
```

#### Broadcast stream
```dart
final broadcast = singleStream().asBroadcastStream();

// Pierwsza subskrypcja - działa
await for (final value in broadcast) {
  print('Subskrypcja 1: $value');
}

// Druga subskrypcja - też działa!
await for (final value in broadcast) {
  print('Subskrypcja 2: $value');
}
```

#### StreamController jako broadcast
```dart
final controller = StreamController<int>.broadcast();

// Wiele listenerów
controller.stream.listen((value) {
  print('Listener 1: $value');
});

controller.stream.listen((value) {
  print('Listener 2: $value');
});

// Wszyscy listenerzy otrzymują te same wartości
controller.add(1);
controller.add(2);
controller.add(3);
controller.close();
```

## Kluczowe różnice

| Future | Stream |
|--------|--------|
| Pojedyncza wartość | Sekwencja wartości |
| `await` | `await for` |
| `then()`, `catchError()` | `listen()`, `map()`, `where()` |
| Idealny dla API calls | Idealny dla real-time data |

## Wskazówki

1. **Future** - używaj dla operacji które zwracają jedną wartość (API calls, file operations)
2. **Stream** - używaj dla ciągłych danych (websockets, user input, sensor data)
3. **async/await** - preferuj nad `.then()` dla czytelności
4. **await for** - używaj do iteracji przez stream
5. **Zawsze obsługuj błędy** - używaj try-catch lub onError
6. **Single vs Broadcast** - single-subscription stream można subskrybować tylko raz, broadcast - wielokrotnie
7. **StreamController.broadcast()** - używaj gdy potrzebujesz wielu listenerów
8. **asBroadcastStream()** - konwertuj single stream na broadcast gdy potrzebujesz wielokrotnej subskrypcji

## Konstruktory Stream - kiedy używać

| Konstruktor | Kiedy używać | Przykład użycia |
|-------------|--------------|-----------------|
| `Stream.periodic()` | Interwały czasowe | Timer, polling, heartbeat |
| `Stream.fromIterable()` | Z istniejącej kolekcji | Lista plików, elementy UI |
| `Stream.fromFuture()` | Z pojedynczego Future | Wynik API call |
| `Stream.fromFutures()` | Z wielu Future | Równoległe API calls |
| `Stream.value()` | Pojedyncza wartość | Domyślna wartość |
| `Stream.error()` | Stream z błędem | Testowanie obsługi błędów |
| `Stream.empty()` | Pusty stream | Brak danych |
| `Stream.multi()` | Niestandardowa logika | Kompleksowe scenariusze |

## Single vs Broadcast Stream

| Właściwość | Single-subscription | Broadcast |
|------------|-------------------|-----------|
| **Liczba subskrypcji** | Tylko jedna | Nieograniczona |
| **Wydajność** | Generator wykonuje się raz | Generator wykonuje się dla każdej subskrypcji |
| **Pamięć** | Mniej pamięci | Więcej pamięci (cache) |
| **Użycie** | Domyślne | `.asBroadcastStream()` lub `StreamController.broadcast()` |
| **Przykład** | `Stream.periodic()` | `StreamController.broadcast()` |

## RxDart Przykłady

### 1. Subjects

#### BehaviorSubject
```dart
final subject = BehaviorSubject<int>();

// Dodaj wartości
subject.add(1);
subject.add(2);

// Nowi subskrybenci otrzymują ostatnią wartość
subject.stream.listen((value) {
  print('Otrzymano: $value'); // 2
});
```

#### ReplaySubject
```dart
final subject = ReplaySubject<int>();

// Dodaj wartości
subject.add(1);
subject.add(2);
subject.add(3);

// Nowi subskrybenci otrzymują wszystkie wartości
subject.stream.listen((value) {
  print('Otrzymano: $value'); // 1, 2, 3
});
```

#### PublishSubject
```dart
final subject = PublishSubject<int>();

// Dodaj wartości
subject.add(1);
subject.add(2);

// Nowi subskrybenci otrzymują tylko nowe wartości
subject.stream.listen((value) {
  print('Otrzymano: $value'); // tylko nowe wartości
});
```

### 2. Operators

#### Merge i Zip
```dart
// Merge - łączy streamy
final merged = Rx.merge([stream1, stream2, stream3]);

// Zip - łączy wartości
final zipped = Rx.zip2(stream1, stream2, (a, b) => '$a-$b');
```

#### Throttle i Debounce
```dart
// Throttle - ogranicza częstotliwość
stream.throttleTime(Duration(milliseconds: 500));

// Debounce - czeka na koniec serii
stream.debounceTime(Duration(milliseconds: 500));
```

#### Buffer i Window
```dart
// Buffer - gromadzi wartości w grupy
stream.bufferCount(3);

// Window - dzieli na okna czasowe
stream.bufferTime(Duration(seconds: 1));
```

### 3. Advanced

#### CombineLatest
```dart
Rx.combineLatest3(stream1, stream2, stream3, (a, b, c) => '$a-$b-$c')
    .listen((value) {
  print(value);
});
```

#### WithLatestFrom
```dart
mainStream
    .withLatestFrom(otherStream, (main, other) => '$main + $other')
    .listen((value) {
  print(value);
});
```

#### Retry
```dart
Rx.retry(() => riskyStream, 3)
    .listen(
      (value) => print('Sukces: $value'),
      onError: (error) => print('Błąd: $error'),
    );
```

## RxDart vs Standard Stream

| Właściwość | Standard Stream | RxDart |
|------------|----------------|--------|
| **Subjects** | StreamController | BehaviorSubject, ReplaySubject, PublishSubject |
| **Operators** | Podstawowe | Zaawansowane (throttle, debounce, merge, zip) |
| **Combinators** | Brak | combineLatest, withLatestFrom, switchMap |
| **Error Handling** | Podstawowe | retry, retryWhen, timeoutWithFallback |
| **Backpressure** | Brak | throttle, sample, buffer |
| **Użycie** | Proste aplikacje | Aplikacje z dużą ilością streamów |

## Wskazówki RxDart

1. **BehaviorSubject** - używaj gdy potrzebujesz ostatniej wartości
2. **ReplaySubject** - używaj gdy potrzebujesz historii wartości
3. **PublishSubject** - używaj gdy nie potrzebujesz historii
4. **throttleTime** - używaj dla ograniczenia częstotliwości (np. kliknięcia)
5. **debounceTime** - używaj dla wyszukiwania (np. pole tekstowe)
6. **combineLatest** - używaj gdy potrzebujesz najnowszych wartości z wielu streamów
7. **switchMap** - używaj gdy chcesz anulować poprzednie operacje
8. **flatMap** - używaj gdy chcesz połączyć wszystkie operacje