# Lekcja 3: Envied + Dart Define z środowiskami

## 🎯 Cel Lekcji

Nauczysz się używać biblioteki `envied` do profesjonalnego zarządzania środowiskami w aplikacjach Flutter.

## 🔧 Jak to Działa

### 1. **Pliki .env dla różnych środowisk**
```
.env/
├── .env.dev        # Development environment
├── .env.staging    # Staging environment
└── .env.prod       # Production environment
```

### 2. **Klasa Envied z automatycznym generowaniem**
```dart
@Envied(path: '.env/.env.dev')
abstract class DevEnv {
  @EnviedField(varName: 'APP_NAME')
  static const String appName = _DevEnv.appName;
  
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _DevEnv.apiBaseUrl;
  // ... inne pola
}
```

### 3. **Automatyczne przełączanie środowisk**
```dart
factory AppConfig.fromEnvironment() {
  const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
  
  switch (environment) {
    case 'dev': return AppConfig.fromDevEnv();
    case 'staging': return AppConfig.fromStagingEnv();
    case 'prod': return AppConfig.fromProdEnv();
  }
}
```

## 🚀 Jak Uruchamiać

### Opcja 1: Automatyczne setup
```bash
# Pierwsze uruchomienie - generuje pliki env
./scripts/setup.sh

# Następnie uruchamiaj z różnymi środowiskami
./scripts/run_dev.sh
./scripts/run_staging.sh
./scripts/run_prod.sh
```

### Opcja 2: Manualne kroki
```bash
# 1. Zainstaluj zależności
flutter pub get

# 2. Wygeneruj pliki env
dart run build_runner build

# 3. Uruchom z różnymi środowiskami
flutter run --dart-define=ENVIRONMENT=dev
flutter run --dart-define=ENVIRONMENT=staging
flutter run --dart-define=ENVIRONMENT=prod
```

## 📋 Struktura Projektu

```
lib/
├── main.dart                 # Główny plik aplikacji
├── config/
│   └── app_config.dart       # Klasa konfiguracji
└── env/
    └── env.dart              # Klasy Envied dla różnych środowisk

.env/
├── .env.dev                  # Development variables
├── .env.staging              # Staging variables
└── .env.prod                 # Production variables

scripts/
├── setup.sh                  # Setup script
├── run_dev.sh                # Run development
├── run_staging.sh            # Run staging
└── run_prod.sh               # Run production
```

## 🔄 Build Commands

### Development Build
```bash
flutter build apk --dart-define=ENVIRONMENT=dev
```

### Staging Build
```bash
flutter build apk --dart-define=ENVIRONMENT=staging
```

### Production Build
```bash
flutter build apk --dart-define=ENVIRONMENT=prod
```

## ✅ Zalety Envied

- **Type-safe**: Kompilator sprawdza poprawność typów
- **Compile-time validation**: Błędy wykrywane podczas kompilacji
- **Automatic code generation**: Nie musisz pisać boilerplate kodu
- **IDE support**: Pełne wsparcie autocomplete
- **No runtime errors**: Brak błędów dla brakujących zmiennych
- **Secure**: Zmienne są obfuskowane w kodzie
- **Environment-specific**: Różne pliki dla różnych środowisk

## ❌ Wady

- **Dodatkowa zależność**: Potrzebujesz `envied` i `build_runner`
- **Build step**: Musisz uruchomić `build_runner` po zmianie .env
- **Learning curve**: Trzeba nauczyć się nowej biblioteki
- **Generated code**: Kod jest generowany automatycznie

## 🎯 Kiedy Używać

- **Duże projekty** z wieloma środowiskami
- **Zespoły** gdzie różni developerzy używają różnych konfiguracji
- **CI/CD pipelines** z automatycznym budowaniem
- **Aplikacje** gdzie bezpieczeństwo jest ważne
- **Projekty** gdzie potrzebujesz type-safety

## 📝 Zadania

1. **Dodaj nowe zmienne** do plików .env (np. `DATABASE_URL`, `API_KEY`)
2. **Stwórz nowe środowisko** `test` z własną konfiguracją
3. **Dodaj walidację** zmiennych środowiskowych
4. **Stwórz widget** do wyświetlania wszystkich zmiennych z .env
5. **Dodaj obsługę** różnych typów danych (List, Map)

## 🔄 Następna Lekcja

W następnej lekcji nauczysz się integrować z native build variants Android!

---

**Powodzenia! 🚀**