# Native Plugin - Method Channel & Event Channel Demo

Ten plugin Flutter demonstruje użycie **Method Channel** i **Event Channel** do komunikacji między Flutter a natywnym kodem (Android/iOS).

## 🎯 Cel Szkolenia

Plugin został stworzony specjalnie do celów szkoleniowych, aby pokazać:

1. **Method Channel** - komunikacja synchroniczna Flutter ↔ Native
2. **Event Channel** - komunikacja asynchroniczna (streaming) Flutter ↔ Native
3. Implementacja po stronie Android (Kotlin)
4. Implementacja po stronie iOS (Swift)

## 📱 Funkcjonalności

### Method Channel Examples

#### 1. **getPlatformVersion()**
- Zwraca wersję systemu operacyjnego
- **Android**: `"Android ${Build.VERSION.RELEASE}"`
- **iOS**: `"iOS ${UIDevice.current.systemVersion}"`

#### 2. **calculateSum(int a, int b)**
- Oblicza sumę dwóch liczb po stronie native
- Przykład: `calculateSum(15, 25)` → `40`

#### 3. **getDeviceInfo()**
- Zwraca informacje o urządzeniu
- **Android**: brand, model, version, SDK, manufacturer
- **iOS**: brand, model, version, name, identifier

### Event Channel Examples

#### **Random Number Stream**
- Generuje losowe liczby co sekundę
- Zakres: 1-100
- Przykład użycia:
```dart
_nativePlugin.getRandomNumberStream().listen((number) {
  print('Random number: $number');
});
```

## 🏗️ Architektura

### Flutter Side (Dart)

```
lib/
├── native_plugin.dart                    # Główny interfejs plugin
├── native_plugin_platform_interface.dart # Abstrakcyjna klasa bazowa
└── native_plugin_method_channel.dart    # Implementacja Method/Event Channel
```

### Android Side (Kotlin)

```kotlin
class NativePlugin: FlutterPlugin, MethodCallHandler {
  // Method Channel
  private lateinit var methodChannel: MethodChannel
  
  // Event Channels
  private lateinit var randomNumberEventChannel: EventChannel
  
  // Stream handlers
  private val randomNumberStreamHandler = RandomNumberStreamHandler()
}
```

### iOS Side (Swift)

```swift
public class NativePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  // Method Channel
  private var methodChannel: FlutterMethodChannel?
  
  // Event Channels
  private var randomNumberEventChannel: FlutterEventChannel?
  
  // Event sinks
  private var randomNumberEventSink: FlutterEventSink?
}
```

## 🚀 Jak Uruchomić

### 1. Przejdź do katalogu example
```bash
cd packages/native_plugin/example
```

### 2. Zainstaluj zależności
```bash
flutter pub get
```

### 3. Uruchom aplikację
```bash
# Android
flutter run

# iOS
flutter run -d ios
```

## 📚 Przykłady Użycia

### Method Channel - Podstawowe Użycie

```dart
import 'package:native_plugin/native_plugin.dart';

final plugin = NativePlugin();

// Pobierz wersję platformy
final version = await plugin.getPlatformVersion();
print('Platform: $version');

// Oblicz sumę
final result = await plugin.calculateSum(10, 20);
print('Sum: $result');

// Pobierz informacje o urządzeniu
final deviceInfo = await plugin.getDeviceInfo();
print('Device: $deviceInfo');
```

### Event Channel - Streaming Data

```dart
import 'dart:async';

// Random numbers stream
StreamSubscription<int>? subscription;
subscription = plugin.getRandomNumberStream().listen((number) {
  print('Random: $number');
});

// Pamiętaj o anulowaniu subskrypcji!
subscription?.cancel();
```

## 🔧 Implementacja - Kluczowe Punkty

### Method Channel

#### Flutter → Native
```dart
// Flutter
final result = await methodChannel.invokeMethod('calculateSum', {
  'a': 15,
  'b': 25,
});
```

#### Native → Flutter
```kotlin
// Android
override fun onMethodCall(call: MethodCall, result: Result) {
  when (call.method) {
    "calculateSum" -> {
      val a = call.argument<Int>("a") ?: 0
      val b = call.argument<Int>("b") ?: 0
      result.success(a + b)
    }
  }
}
```

### Event Channel

#### Flutter → Native (Start Stream)
```dart
// Flutter
Stream<int> getRandomNumberStream() {
  return randomNumberEventChannel.receiveBroadcastStream().map((event) {
    return event as int;
  });
}
```

#### Native → Flutter (Send Data)
```kotlin
// Android
private fun startRandomNumberStream() {
  runnable = object : Runnable {
    override fun run() {
      if (eventSink != null) {
        val randomNumber = Random.nextInt(1, 101)
        eventSink?.success(randomNumber)
        handler.postDelayed(this, 1000)
      }
    }
  }
  handler.post(runnable!!)
}
```

## 🎓 Punkty Szkoleniowe

### 1. **Method Channel**
- ✅ Komunikacja synchroniczna
- ✅ Przekazywanie parametrów
- ✅ Obsługa błędów
- ✅ Zwracanie wartości

### 2. **Event Channel**
- ✅ Komunikacja asynchroniczna
- ✅ Streaming danych
- ✅ Zarządzanie cyklem życia streamów

### 3. **Platform Differences**
- ✅ Android: `MethodChannel`, `EventChannel`, `Handler`
- ✅ iOS: `FlutterMethodChannel`, `FlutterEventChannel`, `Timer`
- ✅ Różnice w API między platformami

### 4. **Best Practices**
- ✅ Proper resource cleanup
- ✅ Error handling
- ✅ Memory management
- ✅ Thread safety

## 🐛 Debugging Tips

### 1. **Sprawdź logi**
```bash
flutter logs
```

### 2. **Testuj na różnych platformach**
- Android Emulator
- iOS Simulator
- Fizyczne urządzenia

### 3. **Sprawdź channel names**
- Method Channel: `"native_plugin"`
- Event Channels: `"native_plugin/random_numbers"`

### 4. **Obsługa błędów**
```dart
try {
  final result = await plugin.calculateSum(10, 20);
} on PlatformException catch (e) {
  print('Error: ${e.message}');
}
```

## 📖 Dodatkowe Materiały

- [Flutter Platform Channels](https://docs.flutter.dev/development/platform-integration/platform-channels)
- [Method Channel](https://api.flutter.dev/flutter/services/MethodChannel-class.html)
- [Event Channel](https://api.flutter.dev/flutter/services/EventChannel-class.html)
- [Writing custom platform-specific code](https://docs.flutter.dev/development/platform-integration/platform-channels)

## 🎯 Zadania dla Uczniów

1. **Dodaj nową metodę** do Method Channel (np. `multiply`)
2. **Stwórz nowy Event Channel** (np. timer countdown)
3. **Dodaj obsługę błędów** w native code
4. **Zaimplementuj** funkcję zapisywania danych do pliku
5. **Dodaj** obsługę różnych typów danych (List, Map, etc.)

---

**Powodzenia w nauce! 🚀**