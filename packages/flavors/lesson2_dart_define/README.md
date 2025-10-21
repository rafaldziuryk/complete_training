# Lekcja 2: Dart Define z parametrami

## 🎯 Cel Lekcji

Nauczysz się używać `--dart-define` do przekazywania parametrów konfiguracyjnych bez zmiany kodu aplikacji.

## 🔧 Jak to Działa

### 1. **Czytanie z Environment**
```dart
class AppConfig {
  factory AppConfig.fromEnvironment() {
    return AppConfig(
      appName: const String.fromEnvironment('APP_NAME', defaultValue: 'Flavors Demo'),
      apiBaseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'https://api.example.com'),
      environment: const String.fromEnvironment('ENVIRONMENT', defaultValue: 'unknown'),
      enableLogging: const bool.fromEnvironment('ENABLE_LOGGING', defaultValue: false),
    );
  }
}
```

### 2. **Przekazywanie Parametrów**
```bash
flutter run --dart-define=ENVIRONMENT=dev \
            --dart-define=API_BASE_URL=https://api-dev.example.com \
            --dart-define=ENABLE_LOGGING=true
```

### 3. **Automatyczne Ładowanie**
```dart
void main() {
  // Konfiguracja jest automatycznie ładowana z dart-define
  final config = AppConfig.fromEnvironment();
  runApp(MyApp(config: config));
}
```

## 🚀 Jak Uruchamiać

### Opcja 1: Bezpośrednio z parametrami
```bash
# Development
flutter run --dart-define=ENVIRONMENT=dev --dart-define=ENABLE_LOGGING=true

# Staging  
flutter run --dart-define=ENVIRONMENT=staging --dart-define=API_BASE_URL=https://api-staging.example.com

# Production
flutter run --dart-define=ENVIRONMENT=prod --dart-define=ENABLE_LOGGING=false
```

### Opcja 2: Używając skryptów
```bash
# Development
./scripts/run_dev.sh

# Staging
./scripts/run_staging.sh

# Production
./scripts/run_prod.sh
```

## 📋 Dostępne Parametry

| Parametr | Typ | Opis | Przykład |
|----------|-----|------|----------|
| `ENVIRONMENT` | String | Nazwa środowiska | `dev`, `staging`, `prod` |
| `APP_NAME` | String | Nazwa aplikacji | `"Flavors Demo - DEV"` |
| `API_BASE_URL` | String | URL API | `https://api-dev.example.com` |
| `ENABLE_LOGGING` | Bool | Czy włączyć logowanie | `true`, `false` |
| `ANALYTICS_ENABLED` | String | Czy włączyć analytics | `"true"`, `"false"` |
| `CRASHLYTICS_ENABLED` | String | Czy włączyć crashlytics | `"true"`, `"false"` |
| `DEBUG_MENU_ENABLED` | String | Czy włączyć debug menu | `"true"`, `"false"` |
| `FEATURE_FLAGS_ENABLED` | String | Czy włączyć feature flags | `"true"`, `"false"` |

## ✅ Zalety

- **Elastyczne**: Można zmieniać konfigurację bez zmiany kodu
- **Bezpieczne**: Nie ma ryzyka zapomnienia o zmianie konfiguracji
- **Skalowalne**: Łatwo dodać nowe parametry
- **CI/CD Friendly**: Idealne do automatyzacji

## ❌ Wady

- **Długie komendy**: Trzeba pamiętać o wszystkich parametrach
- **Brak walidacji**: Nie ma sprawdzania poprawności parametrów
- **String-based**: Wszystko jest przekazywane jako stringi
- **Runtime only**: Parametry są dostępne tylko w runtime

## 🎯 Kiedy Używać

- **Średnie projekty** z częstymi zmianami konfiguracji
- **CI/CD pipelines** gdzie konfiguracja zmienia się automatycznie
- **Projekty** gdzie różne zespoły używają różnych środowisk
- **Aplikacje** które są budowane dla różnych klientów

## 🔄 Build Commands

### Development Build
```bash
flutter build apk --dart-define=ENVIRONMENT=dev --dart-define=ENABLE_LOGGING=true
```

### Production Build
```bash
flutter build apk --dart-define=ENVIRONMENT=prod --dart-define=ENABLE_LOGGING=false
```

### iOS Build
```bash
flutter build ios --dart-define=ENVIRONMENT=prod --dart-define=ENABLE_LOGGING=false
```

## 📝 Zadania

1. **Dodaj nowy parametr** `VERSION` i wyświetl go w aplikacji
2. **Stwórz skrypt** do budowania APK z różnymi środowiskami
3. **Dodaj walidację** parametrów (np. sprawdź czy URL jest poprawny)
4. **Stwórz widget** do wyświetlania wszystkich parametrów z dart-define

## 🔄 Następna Lekcja

W następnej lekcji nauczysz się używać biblioteki `envied` do jeszcze lepszego zarządzania środowiskami!

---

**Powodzenia! 🚀**