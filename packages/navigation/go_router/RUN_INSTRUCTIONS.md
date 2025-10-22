# Instrukcje uruchomienia - Go Router Demo

## Wymagania
- Flutter SDK (wersja 3.0.0 lub nowsza)
- Android Studio / VS Code / IntelliJ IDEA
- Emulator Android lub iOS (opcjonalnie)

## Kroki uruchomienia

### 1. Przejdź do folderu projektu
```bash
cd packages/navigation/go_router
```

### 2. Zainstaluj zależności
```bash
flutter pub get
```

### 3. Sprawdź czy wszystko działa
```bash
flutter analyze
```

### 4. Uruchom aplikację

#### Na emulatorze Android:
```bash
flutter run
```

#### Na emulatorze iOS:
```bash
flutter run -d ios
```

#### Na przeglądarce (Web):
```bash
flutter run -d chrome
```

## Struktura aplikacji

### Główny ekran (HomeScreen)
- Przyciski do wszystkich typów nawigacji go_router
- Podzielone na kategorie: podstawowe, parametry, nested routes, chronione trasy

### Ekrany demonstracyjne:
1. **ProfileScreen** - Query parameters
2. **SettingsScreen** - Podstawowa nawigacja
3. **UserDetailScreen** - Path parameters
4. **UserEditScreen** - Nested routes
5. **LoginScreen** - Redirect logic
6. **ProtectedScreen** - Route guards
7. **NestedExampleScreen** - Nested routes example
8. **NestedTab1Screen** - Pierwszy nested route
9. **NestedTab2Screen** - Drugi nested route
10. **ErrorScreen** - Error handling

## Co można przetestować

### Podstawowe funkcje go_router:
- ✅ Named routes navigation
- ✅ Path parameters (/user/:userId)
- ✅ Query parameters (?name=John&age=25)
- ✅ Nested routes (/user/123/edit)
- ✅ Redirect logic (automatyczne przekierowania)
- ✅ Error handling (obsługa błędów)

### Zaawansowane funkcje:
- ✅ Route guards (chronione trasy)
- ✅ Deep linking (URL w przeglądarce)
- ✅ State management (automatyczne zarządzanie stanem)
- ✅ Type safety (bezpieczne typowanie parametrów)

## Wskazówki do testowania

### 1. Testowanie podstawowej nawigacji
- Kliknij "Profile Screen" - sprawdź podstawową nawigację
- Kliknij "Settings Screen" - sprawdź nawigację do ustawień
- Użyj przycisku "Wróć" - sprawdź nawigację wstecz

### 2. Testowanie path parameters
- Kliknij "User Detail (ID: 123)" - sprawdź przekazywanie ID przez URL
- Kliknij "User Detail (ID: 456)" - sprawdź różne ID
- Zauważ że URL zmienia się na /user/123 lub /user/456

### 3. Testowanie query parameters
- Kliknij "Profile with Query Params" - sprawdź przekazywanie parametrów
- Zauważ że URL zawiera query string: /profile?name=John%20Doe&age=25&city=Warsaw
- Sprawdź czy parametry są wyświetlane na ekranie

### 4. Testowanie nested routes
- Kliknij "Nested Example" - przejdź do przykładu nested routes
- Kliknij "Tab 1" - sprawdź nawigację do /nested/tab1
- Kliknij "Tab 2" - sprawdź nawigację do /nested/tab2
- Zauważ że URL zmienia się odpowiednio

### 5. Testowanie redirect logic
- Kliknij "Protected Screen" - sprawdź automatyczne przekierowanie do logowania
- Zauważ że aplikacja automatycznie przekierowuje do /login
- Kliknij "Zaloguj się" - sprawdź proces logowania
- Kliknij "Pomiń logowanie" - sprawdź obejście logowania

### 6. Testowanie deep linking (Web)
- Uruchom aplikację w przeglądarce
- Skopiuj URL z paska adresu
- Otwórz nową kartę i wklej URL
- Sprawdź czy aplikacja otwiera się na odpowiednim ekranie

### 7. Testowanie error handling
- Spróbuj przejść do nieistniejącej trasy
- Sprawdź czy wyświetla się ekran błędów
- Użyj przycisku "Wróć do Home" - sprawdź powrót do głównego ekranu

## Rozwiązywanie problemów

### Błąd: "Target of URI doesn't exist"
```bash
flutter clean
flutter pub get
```

### Błąd: "No connected devices"
```bash
flutter devices
# Uruchom emulator lub podłącz urządzenie
```

### Błąd: "Flutter not found"
```bash
# Dodaj Flutter do PATH lub użyj pełnej ścieżki
export PATH="$PATH:/path/to/flutter/bin"
```

### Błąd: "Go Router not found"
```bash
flutter pub get
# Sprawdź czy go_router jest w pubspec.yaml
```

## Dodatkowe informacje

- Aplikacja używa Material Design 3
- Wszystkie przykłady są interaktywne
- Kod zawiera szczegółowe komentarze
- Każdy ekran ma własny kolor dla łatwiejszej identyfikacji
- Aplikacja jest w pełni responsywna
- Obsługuje deep linking na wszystkich platformach

## Następne kroki

Po przetestowaniu podstawowych funkcji go_router, możesz:
1. Dodać własne trasy
2. Implementować zaawansowaną autoryzację
3. Dodać custom transitions
4. Implementować state management z go_router
5. Dodać testy jednostkowe dla routera
6. Eksperymentować z deep linking
7. Implementować route guards
8. Dodać animacje przejść

## Porównanie z Navigator

| Funkcja | Navigator | go_router |
|---------|-----------|-----------|
| **Typ nawigacji** | Imperatywna | Deklaratywna |
| **URL Support** | Brak | Pełne wsparcie |
| **Deep Linking** | Ograniczone | Natywne |
| **State Management** | Manualne | Automatyczne |
| **Type Safety** | Ograniczone | Pełne |
| **Web Support** | Podstawowe | Zaawansowane |
| **Learning Curve** | Łatwa | Średnia |
| **Maintenance** | Trudna | Łatwa |

## Wskazówki dla deweloperów

1. **Zacznij od prostych tras** - Nie komplikuj na początku
2. **Używaj named routes** - Łatwiejsze w utrzymaniu
3. **Testuj deep linking** - Sprawdź czy URL działają
4. **Dokumentuj trasy** - Utrzymuj dokumentację
5. **Używaj type safety** - Wykorzystuj typowanie
6. **Centralizuj redirect logic** - Używaj globalnego redirect
7. **Obsługuj błędy** - Zawsze implementuj error handling
8. **Testuj na różnych platformach** - Sprawdź kompatybilność

