# Lekcja 4: Android Flavors + Envied

## 🎯 Cel Lekcji

Nauczysz się jak integrować prawdziwe Android flavors z Flutter konfiguracją Envied, tworząc różne aplikacje z różnymi appId, nazwami i konfiguracjami.

## 🔧 Jak to Działa

### 1. **Android Flavors w build.gradle.kts**
```kotlin
productFlavors {
    create("dev") {
        dimension = "environment"
        applicationId = "com.example.flavorsdemo.dev"
        resValue("string", "app_name", "Flavors Demo DEV")
        resValue("color", "primary_color", "#4CAF50") // Green
        buildConfigField("String", "API_BASE_URL", "\"https://api-dev.example.com\"")
    }
    
    create("staging") {
        dimension = "environment"
        applicationId = "com.example.flavorsdemo.staging"
        resValue("string", "app_name", "Flavors Demo STAGING")
        resValue("color", "primary_color", "#FF9800") // Orange
    }
    
    create("prod") {
        dimension = "environment"
        applicationId = "com.example.flavorsdemo"
        resValue("string", "app_name", "Flavors Demo")
        resValue("color", "primary_color", "#2196F3") // Blue
    }
}
```

### 2. **Różne App ID dla różnych środowisk**
```
Development:  com.example.flavorsdemo.dev
Staging:      com.example.flavorsdemo.staging
Production:   com.example.flavorsdemo
```

### 3. **Różne nazwy aplikacji**
```
Development:  Flavors Demo DEV
Staging:      Flavors Demo STAGING
Production:   Flavors Demo
```

### 4. **Różne kolory dla różnych środowisk**
```
Development:  Green (#4CAF50)
Staging:      Orange (#FF9800)
Production:   Blue (#2196F3)
```

## 🚀 Jak Uruchamiać

### Opcja 1: Automatyczne setup
```bash
# Pierwsze uruchomienie - generuje pliki env
./scripts/setup.sh

# Następnie buduj z różnymi Android flavors
./scripts/build_dev.sh
./scripts/build_staging.sh
./scripts/build_prod.sh
```

### Opcja 2: Manualne kroki
```bash
# 1. Zainstaluj zależności
flutter pub get

# 2. Wygeneruj pliki env
dart run build_runner build

# 3. Buduj z różnymi Android flavors
flutter build apk --flavor dev --release
flutter build apk --flavor staging --release
flutter build apk --flavor prod --release
```

## 📋 Struktura Projektu

```
lib/
├── main.dart                 # Główny plik aplikacji
├── config/
│   └── app_config.dart       # Klasa konfiguracji z Android info
└── env/
    └── env.dart              # Klasy Envied z native build fields

android/app/
├── build.gradle.kts          # Android flavors configuration
└── src/
    ├── dev/res/values/        # Development resources
    ├── staging/res/values/    # Staging resources
    └── prod/res/values/       # Production resources

.env/
├── .env.dev                  # Development + native config
├── .env.staging              # Staging + native config
└── .env.prod                 # Production + native config

scripts/
├── setup.sh                  # Setup script
├── build_dev.sh              # Build development
├── build_staging.sh          # Build staging
└── build_prod.sh             # Build production
```

## 🔄 Build Commands

### Development Build
```bash
flutter build apk --flavor dev --release
# Tworzy: com.example.flavorsdemo.dev (Green)
```

### Staging Build
```bash
flutter build apk --flavor staging --release
# Tworzy: com.example.flavorsdemo.staging (Orange)
```

### Production Build
```bash
flutter build apk --flavor prod --release
# Tworzy: com.example.flavorsdemo (Blue)
```

## 📱 Rezultaty Buildów

| Environment | App ID | App Name | Color | APK File |
|-------------|--------|----------|-------|----------|
| Development | `com.example.flavorsdemo.dev` | Flavors Demo DEV | Green | app-dev-release.apk |
| Staging | `com.example.flavorsdemo.staging` | Flavors Demo STAGING | Orange | app-staging-release.apk |
| Production | `com.example.flavorsdemo` | Flavors Demo | Blue | app-prod-release.apk |

## ✅ Zalety Android Flavors + Envied

- **Różne aplikacje**: Każde środowisko to osobna aplikacja
- **Jednoczesna instalacja**: Można mieć wszystkie wersje na urządzeniu
- **Różne kolory**: Każda wersja ma swój kolor
- **Osobne App Store**: Różne listingi w sklepach
- **Niezależne wersjonowanie**: Każda ma swój numer wersji
- **Różne klucze**: Można używać różnych kluczy podpisywania
- **Environment-specific**: Konfiguracja dostosowana do środowiska
- **Native + Flutter**: Kombinacja Android flavors z Flutter Envied
- **Type-safe**: Envied zapewnia type-safety w Flutter

## ❌ Wady

- **Złożoność**: Bardziej skomplikowane niż podstawowe flavors
- **Więcej plików**: Trzeba zarządzać więcej konfiguracjami
- **Native knowledge**: Wymaga znajomości Android
- **Build time**: Dłuższy czas budowania
- **Maintenance**: Więcej rzeczy do utrzymania

## 🎯 Kiedy Używać

- **Duże projekty** z wieloma środowiskami
- **Zespoły** gdzie różni developerzy testują różne wersje
- **CI/CD pipelines** z automatycznym budowaniem
- **Aplikacje** które są publikowane w różnych wersjach
- **Projekty** gdzie potrzebujesz różnych App Store listingów
- **Aplikacje** gdzie potrzebujesz native Android features

## 🔧 Konfiguracja Android Flavors

### 1. **Różne kolory dla różnych środowisk**
```xml
<!-- android/app/src/dev/res/values/colors.xml -->
<color name="primary_color">#4CAF50</color>

<!-- android/app/src/staging/res/values/colors.xml -->
<color name="primary_color">#FF9800</color>

<!-- android/app/src/prod/res/values/colors.xml -->
<color name="primary_color">#2196F3</color>
```

### 2. **Różne stringi dla różnych środowisk**
```xml
<!-- android/app/src/dev/res/values/strings.xml -->
<string name="app_name">Flavors Demo DEV</string>

<!-- android/app/src/staging/res/values/strings.xml -->
<string name="app_name">Flavors Demo STAGING</string>

<!-- android/app/src/prod/res/values/strings.xml -->
<string name="app_name">Flavors Demo</string>
```

### 3. **BuildConfig fields w Gradle**
```kotlin
buildConfigField("String", "API_BASE_URL", "\"https://api-dev.example.com\"")
buildConfigField("boolean", "ENABLE_LOGGING", "true")
buildConfigField("String", "ENVIRONMENT", "\"dev\"")
```

## 📝 Zadania

1. **Dodaj różne ikony** dla każdego środowiska
2. **Stwórz różne layouty** dla każdego środowiska
3. **Dodaj różne wersjonowanie** dla każdego środowiska
4. **Skonfiguruj różne klucze** podpisywania
5. **Dodaj różne permissions** dla każdego środowiska

## 🔄 Następne Kroki

Po ukończeniu tej lekcji będziesz potrafił:
- Konfigurować Android flavors w Gradle
- Zarządzać różnymi środowiskami w Flutter
- Tworzyć różne aplikacje z różnymi App ID
- Łączyć native Android features z Flutter
- Budować aplikacje dla różnych środowisk
- Zarządzać konfiguracją w sposób profesjonalny

---

**Gratulacje! Ukończyłeś kompletny kurs Flutter Flavors z Android flavors! 🎉**