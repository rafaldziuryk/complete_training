# Native Plugin - Training Summary

## 🎯 Co Demonstruje Plugin

Ten plugin Flutter został stworzony specjalnie do celów szkoleniowych i demonstruje:

### 1. **Method Channel** - Komunikacja Synchroniczna
- Wywołania metod z Flutter do native code
- Przekazywanie parametrów i otrzymywanie wyników
- Obsługa błędów i wyjątków

### 2. **Event Channel** - Komunikacja Asynchroniczna  
- Streaming danych z native code do Flutter
- Ciągłe przesyłanie danych w czasie rzeczywistym
- Zarządzanie cyklem życia streamów

### 3. **Cross-Platform Implementation**
- Implementacja po stronie Android (Kotlin)
- Implementacja po stronie iOS (Swift)
- Różnice w API między platformami

## 🔧 Kluczowe Implementacje

### Method Channel Examples

#### **getPlatformVersion()**
```dart
// Flutter
final version = await plugin.getPlatformVersion();
```
```kotlin
// Android
result.success("Android ${android.os.Build.VERSION.RELEASE}")
```
```swift
// iOS
result("iOS " + UIDevice.current.systemVersion)
```

#### **calculateSum(int a, int b)**
```dart
// Flutter
final result = await plugin.calculateSum(15, 25);
```
```kotlin
// Android
val a = call.argument<Int>("a") ?: 0
val b = call.argument<Int>("b") ?: 0
result.success(a + b)
```

#### **getDeviceInfo()**
```dart
// Flutter
final deviceInfo = await plugin.getDeviceInfo();
```
```kotlin
// Android
val deviceInfo = mapOf(
  "brand" to android.os.Build.BRAND,
  "model" to android.os.Build.MODEL,
  "version" to android.os.Build.VERSION.RELEASE
)
result.success(deviceInfo)
```

### Event Channel Examples

#### **Random Number Stream**
```dart
// Flutter
plugin.getRandomNumberStream().listen((number) {
  print('Random: $number');
});
```
```kotlin
// Android
private fun startRandomNumberStream() {
  runnable = object : Runnable {
    override fun run() {
      val randomNumber = Random.nextInt(1, 101)
      eventSink?.success(randomNumber)
      handler.postDelayed(this, 1000)
    }
  }
  handler.post(runnable!!)
}
```
```swift
// iOS
private func startRandomNumberStream() {
  randomNumberTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
    let randomNumber = Int.random(in: 1...100)
    eventSink(randomNumber)
  }
}
```

## 📱 Demo App Features

### Method Channel Demo
- **Platform Version**: Wyświetla wersję systemu operacyjnego
- **Calculate Sum**: Oblicza sumę dwóch liczb (15 + 25)
- **Device Info**: Pokazuje szczegółowe informacje o urządzeniu

### Event Channel Demo
- **Random Number Stream**: Generuje losowe liczby co sekundę (1-100)
- **Start/Stop Controls**: Przyciski do kontrolowania streamu

## 🎓 Punkty Szkoleniowe

### 1. **Method Channel**
- ✅ Komunikacja synchroniczna Flutter ↔ Native
- ✅ Przekazywanie parametrów przez Map<String, dynamic>
- ✅ Zwracanie wyników przez result.success()
- ✅ Obsługa błędów przez result.error()
- ✅ Różne typy danych (String, Int, Map)

### 2. **Event Channel**
- ✅ Komunikacja asynchroniczna (streaming)
- ✅ EventChannel.receiveBroadcastStream()
- ✅ EventChannel.StreamHandler (Android)
- ✅ FlutterStreamHandler (iOS)
- ✅ Zarządzanie cyklem życia streamów
- ✅ Proper cleanup w onCancel/onDetachedFromEngine

### 3. **Platform Differences**
- ✅ **Android**: MethodChannel, EventChannel, Handler, Runnable
- ✅ **iOS**: FlutterMethodChannel, FlutterEventChannel, Timer
- ✅ **Android**: Random.nextInt()
- ✅ **iOS**: Int.random()

### 4. **Best Practices**
- ✅ Proper resource cleanup (cancel subscriptions, invalidate timers)
- ✅ Error handling (try-catch, PlatformException)
- ✅ Memory management (weak references w iOS)
- ✅ Thread safety (Handler na main thread w Android)
- ✅ Lifecycle management (onAttachedToEngine, onDetachedFromEngine)

### 5. **Architecture Patterns**
- ✅ Platform Interface Pattern
- ✅ Method Channel Pattern
- ✅ Event Channel Pattern
- ✅ Stream Management Pattern
- ✅ Error Handling Pattern

## 🚀 Jak Uruchomić Demo

```bash
cd packages/native_plugin/example
flutter pub get
flutter run
```

## 🎯 Następne Kroki dla Uczniów

1. **Dodaj nową metodę** do Method Channel (np. `multiply`, `divide`)
2. **Stwórz nowy Event Channel** (np. timer countdown, GPS coordinates)
3. **Dodaj obsługę błędów** w native code
4. **Zaimplementuj** funkcję zapisywania danych do pliku
5. **Dodaj** obsługę różnych typów danych (List, Map, custom objects)
6. **Stwórz** plugin z bardziej złożoną logiką biznesową

---

**Plugin gotowy do szkolenia! 🎓**