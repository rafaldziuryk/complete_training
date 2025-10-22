# Navigation Basic Demo

Przykładowa lekcja pokazująca różne metody Navigatora w Flutter.

## Opis

Ta aplikacja demonstruje podstawowe metody nawigacji w Flutter:

### Podstawowe metody nawigacji:
- **Navigator.push()** - Dodaje nowy ekran na stos nawigacji
- **Navigator.pushReplacement()** - Zastępuje obecny ekran nowym
- **Navigator.pushAndRemoveUntil()** - Dodaje nowy ekran i usuwa wszystkie poprzednie
- **Value Return** - Demonstruje przekazywanie wartości przez Navigator.pop()

### Modalne ekrany:
- **showModalBottomSheet()** - Wyświetla modal bottom sheet
- **Fullscreen Dialog** - Otwiera ekran jako fullscreen dialog

### Dialogi i powiadomienia:
- **AlertDialog** - Standardowy dialog z opcjami
- **Custom Dialog** - Niestandardowy dialog z własnym designem
- **SnackBar** - Powiadomienie na dole ekranu

## Struktura projektu

```
lib/
├── main.dart                           # Punkt wejścia aplikacji
├── screens/
│   ├── home_screen.dart               # Główny ekran z przyciskami
│   ├── push_screen.dart               # Ekran demonstrujący push()
│   ├── push_replacement_screen.dart    # Ekran demonstrujący pushReplacement()
│   ├── push_and_remove_until_screen.dart # Ekran demonstrujący pushAndRemoveUntil()
│   ├── value_return_screen.dart         # Ekran demonstrujący przekazywanie wartości
│   ├── modal_screen.dart              # Ekran modalny
│   └── fullscreen_dialog_screen.dart   # Fullscreen dialog
└── widgets/
    ├── custom_dialog.dart             # Niestandardowy dialog
    └── custom_bottom_sheet.dart       # Niestandardowy bottom sheet
```

## Jak uruchomić

1. Przejdź do folderu `packages/navigation/basic`
2. Uruchom `flutter pub get`
3. Uruchom `flutter run`

## Przykłady użycia

### Navigator.push()
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const NextScreen(),
  ),
);
```

### Navigator.pushReplacement()
```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const ReplacementScreen(),
  ),
);
```

### Navigator.pushAndRemoveUntil()
```dart
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => const NewScreen(),
  ),
  (route) => false, // Usuwa wszystkie poprzednie ekrany
);
```

### showModalBottomSheet()
```dart
showModalBottomSheet(
  context: context,
  builder: (context) => const CustomBottomSheet(),
);
```

### showDialog()
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Tytuł'),
    content: const Text('Treść dialogu'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('OK'),
      ),
    ],
  ),
);
```

### SnackBar
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('Wiadomość'),
    action: SnackBarAction(
      label: 'Akcja',
      onPressed: () {
        // Akcja
      },
    ),
  ),
);
```

## Kluczowe różnice między metodami

| Metoda | Efekt | Stos nawigacji |
|--------|-------|----------------|
| `push()` | Dodaje nowy ekran | Ekrany pozostają na stosie |
| `pushReplacement()` | Zastępuje obecny ekran | Usuwa obecny ekran |
| `pushAndRemoveUntil()` | Dodaje nowy i usuwa poprzednie | Czyści stos do określonego punktu |
| `pop()` | Wraca do poprzedniego ekranu | Usuwa obecny ekran ze stosu |

## Wskazówki

1. **Navigator.push()** - Używaj gdy chcesz zachować możliwość powrotu
2. **Navigator.pushReplacement()** - Używaj przy logowaniu/wylogowaniu
3. **Navigator.pushAndRemoveUntil()** - Używaj gdy chcesz "zresetować" nawigację
4. **Modal Bottom Sheet** - Idealny do opcji i akcji
5. **Dialogi** - Używaj do potwierdzeń i informacji
6. **SnackBar** - Idealny do krótkich powiadomień

## Testowanie

### Przekazywanie wartości przez Navigator.pop()
```dart
// W ekranie który zwraca wartość:
Navigator.pop(context, 'Sukces!');

// W ekranie który odbiera wartość:
final result = await Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ValueSenderScreen()),
);
if (result != null) {
  print('Otrzymano: $result');
}
```

Aplikacja zawiera interaktywne przykłady wszystkich metod nawigacji. Kliknij na przyciski aby zobaczyć różne zachowania w akcji.

