# Flutter Flavors - Kompletny Kurs

Ten kurs demonstruje różne podejścia do zarządzania środowiskami (flavors) w aplikacjach Flutter.

## 🎯 Cel Kursu

Nauczysz się jak:
- Zarządzać różnymi środowiskami (dev, staging, production)
- Konfigurować aplikacje dla różnych środowisk
- Używać różnych narzędzi do zarządzania konfiguracją
- Integrować z native build variants

## 📚 Struktura Kursu

### **Lekcja 1: Różne configi w plikach Dart**
- Podstawowe podejście z plikami konfiguracyjnymi
- `config_dev.dart`, `config_prod.dart`
- Przełączanie przez import
- **Zalety**: Proste, łatwe do zrozumienia
- **Wady**: Trzeba pamiętać o zmianie importów

### **Lekcja 2: Dart Define z parametrami**
- Użycie `--dart-define` w buildach
- Przekazywanie parametrów przez komendy
- Czytanie w runtime
- **Zalety**: Elastyczne, nie trzeba zmieniać kodu
- **Wady**: Trzeba pamiętać o parametrach przy buildzie

### **Lekcja 3: Envied + Dart Define z środowiskami**
- Biblioteka `envied` do zarządzania środowiskami
- `.env` pliki dla różnych środowisk
- Automatyczne generowanie kodu
- **Zalety**: Type-safe, automatyczne generowanie
- **Wady**: Dodatkowa zależność

### **Lekcja 4: Android Flavors + Envied**
- Integracja prawdziwych Android flavors z Flutter konfiguracją Envied
- Różne `applicationId` dla każdego środowiska (dev/staging/prod)
- Różne nazwy aplikacji i kolory
- Android flavors w Gradle + Flutter Envied
- **Zalety**: Różne aplikacje, jednoczesna instalacja, pełna kontrola
- **Wady**: Bardziej złożone, wymaga znajomości Android

## 🚀 Jak Używać

Każda lekcja to osobny projekt Flutter:

```bash
# Lekcja 1: Różne configi w plikach Dart
cd lesson1_dart_configs
flutter run

# Lekcja 2: Dart Define z parametrami
cd lesson2_dart_define
flutter run --dart-define=ENVIRONMENT=dev

# Lekcja 3: Envied + Dart Define z środowiskami
cd lesson3_envied_environments
./scripts/setup.sh
./scripts/run_dev.sh

# Lekcja 4: Android Flavors + Envied
cd lesson4_native_variants
./scripts/setup.sh
./scripts/build_dev.sh
```

## 📖 Wymagania

- Flutter SDK
- Android Studio / VS Code
- Podstawowa znajomość Flutter/Dart
- Podstawowa znajomość Android (lekcja 4)

## 🎓 Co Zdobędziesz

Po ukończeniu kursu będziesz potrafił:
- Wybrać odpowiednie podejście do flavors w zależności od projektu
- Zaimplementować różne środowiska w aplikacji Flutter
- Skonfigurować native build variants
- Zarządzać konfiguracją w sposób profesjonalny

---

**Powodzenia w nauce! 🚀**
