# Lekcja 1: Różne configi w plikach Dart

## 🎯 Cel Lekcji

Nauczysz się podstawowego podejścia do zarządzania konfiguracją w aplikacjach Flutter używając różnych plików Dart.

## 📁 Struktura Projektu

```
lib/
├── main.dart                 # Główny plik aplikacji
└── config/
    ├── app_config.dart       # Abstrakcyjna klasa bazowa
    ├── config_dev.dart       # Konfiguracja Development
    ├── config_staging.dart   # Konfiguracja Staging
    └── config_prod.dart      # Konfiguracja Production
```

## 🔧 Jak to Działa

### 1. **Abstrakcyjna Klasa Bazowa**
```dart
abstract class AppConfig {
  String get appName;
  String get apiBaseUrl;
  String get environment;
  bool get enableLogging;
  Map<String, String> get features;
}
```

### 2. **Konkretne Implementacje**
```dart
// config_dev.dart
class DevConfig implements AppConfig {
  @override
  String get appName => 'Flavors Demo - DEV';
  
  @override
  String get apiBaseUrl => 'https://api-dev.example.com';
  
  // ... inne właściwości
}
```

### 3. **Użycie w main.dart**
```dart
import 'config/config_dev.dart'; // Zmień import!

void main() {
  final config = DevConfig(); // Zmień klasę!
  runApp(MyApp(config: config));
}
```

## 🚀 Jak Przełączać Środowiska

### Development
```dart
import 'config/config_dev.dart';
final config = DevConfig();
```

### Staging
```dart
import 'config/config_staging.dart';
final config = StagingConfig();
```

### Production
```dart
import 'config/config_prod.dart';
final config = ProdConfig();
```

## ✅ Zalety

- **Proste**: Łatwe do zrozumienia i implementacji
- **Type-safe**: Kompilator sprawdza poprawność typów
- **IntelliSense**: Pełne wsparcie IDE
- **Brak zależności**: Nie potrzebujesz dodatkowych pakietów

## ❌ Wady

- **Manualne przełączanie**: Musisz pamiętać o zmianie importów
- **Ryzyko błędów**: Łatwo zapomnieć o zmianie konfiguracji
- **Nie elastyczne**: Trudno zmieniać konfigurację w runtime
- **Duplikacja kodu**: Każda konfiguracja to osobna klasa

## 🎯 Kiedy Używać

- **Małe projekty** z prostą konfiguracją
- **Prototypy** i projekty demonstracyjne
- **Nauka** podstaw zarządzania konfiguracją
- **Projekty** gdzie konfiguracja rzadko się zmienia

## 🚀 Uruchomienie

```bash
cd lesson1_dart_configs
flutter run
```

## 📝 Zadania

1. **Dodaj nowe środowisko** `test` z własną konfiguracją
2. **Dodaj nowe właściwości** do `AppConfig` (np. `version`, `buildNumber`)
3. **Stwórz widget** do wyświetlania wszystkich właściwości konfiguracji
4. **Dodaj przycisk** do przełączania między środowiskami (bez restartu)

## 🔄 Następna Lekcja

W następnej lekcji nauczysz się używać `--dart-define` do przekazywania parametrów bez zmiany kodu!

---

**Powodzenia! 🚀**