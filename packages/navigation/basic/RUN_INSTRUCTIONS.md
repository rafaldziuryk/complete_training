# Instrukcje uruchomienia - Navigation Basic Demo

## Wymagania
- Flutter SDK (wersja 3.0.0 lub nowsza)
- Android Studio / VS Code / IntelliJ IDEA
- Emulator Android lub iOS (opcjonalnie)

## Kroki uruchomienia

### 1. Przejdź do folderu projektu
```bash
cd packages/navigation/basic
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
- Przyciski do wszystkich metod nawigacji
- Podzielone na kategorie: podstawowe metody, modalne ekrany, dialogi

### Ekrany demonstracyjne:
1. **PushScreen** - Pokazuje działanie `Navigator.push()`
2. **PushReplacementScreen** - Pokazuje działanie `Navigator.pushReplacement()`
3. **PushAndRemoveUntilScreen** - Pokazuje działanie `Navigator.pushAndRemoveUntil()`
4. **FullscreenDialogScreen** - Pokazuje fullscreen dialog

### Widgety:
1. **CustomDialog** - Niestandardowy dialog z własnym designem
2. **CustomBottomSheet** - Modal bottom sheet z opcjami

## Co można przetestować

### Podstawowe metody nawigacji:
- ✅ Dodawanie nowych ekranów na stos
- ✅ Zastępowanie obecnego ekranu
- ✅ Usuwanie wszystkich poprzednich ekranów
- ✅ Powrót do poprzedniego ekranu

### Modalne ekrany:
- ✅ Modal bottom sheet z opcjami
- ✅ Fullscreen dialog z przyciskiem zamknięcia

### Dialogi i powiadomienia:
- ✅ Alert dialog z opcjami
- ✅ Niestandardowy dialog z własnym designem
- ✅ SnackBar z akcją

## Wskazówki do testowania

1. **Testuj stos nawigacji** - Dodaj kilka ekranów za pomocą push(), a następnie sprawdź jak działa przycisk wstecz
2. **Testuj pushReplacement()** - Zauważ że nie możesz wrócić do poprzedniego ekranu
3. **Testuj pushAndRemoveUntil()** - Zauważ że wszystkie poprzednie ekrany zostały usunięte
4. **Testuj modalne ekrany** - Sprawdź różnice w zachowaniu między zwykłymi ekranami a modalnymi
5. **Testuj dialogi** - Sprawdź różne typy dialogów i ich zachowanie

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

## Dodatkowe informacje

- Aplikacja używa Material Design 3
- Wszystkie przykłady są interaktywne
- Kod zawiera szczegółowe komentarze
- Każdy ekran ma własny kolor dla łatwiejszej identyfikacji
- Aplikacja jest w pełni responsywna

## Następne kroki

Po przetestowaniu podstawowych metod nawigacji, możesz:
1. Dodać własne ekrany
2. Eksperymentować z przekazywaniem danych
3. Dodać animacje przejść
4. Implementować named routes
5. Dodać deep linking

