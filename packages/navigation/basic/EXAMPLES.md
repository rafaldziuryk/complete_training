# Przykłady kodu - Navigation Basic

## Podstawowe metody Navigatora

### 1. Navigator.push() - Dodawanie nowego ekranu
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const NextScreen(),
  ),
);
```

### 2. Navigator.pushReplacement() - Zastępowanie obecnego ekranu
```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const ReplacementScreen(),
  ),
);
```

### 3. Navigator.pushAndRemoveUntil() - Dodawanie i usuwanie poprzednich
```dart
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => const NewScreen(),
  ),
  (route) => false, // Usuwa wszystkie poprzednie ekrany
);
```

### 4. Navigator.pop() - Powrót do poprzedniego ekranu
```dart
Navigator.pop(context);
```

### 5. Navigator.pop() z wartością zwrotną
```dart
Navigator.pop(context, 'Wartość zwrotna');
```

## Modalne ekrany

### 1. showModalBottomSheet() - Modal bottom sheet
```dart
showModalBottomSheet(
  context: context,
  builder: (context) => const CustomBottomSheet(),
);
```

### 2. Fullscreen Dialog
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const FullscreenDialogScreen(),
    fullscreenDialog: true, // Otwiera jako fullscreen dialog
  ),
);
```

## Dialogi

### 1. AlertDialog - Standardowy dialog
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Tytuł'),
    content: const Text('Treść dialogu'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Anuluj'),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          // Akcja po zatwierdzeniu
        },
        child: const Text('OK'),
      ),
    ],
  ),
);
```

### 2. Custom Dialog - Niestandardowy dialog
```dart
showDialog(
  context: context,
  builder: (context) => Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 60, color: Colors.amber),
          const SizedBox(height: 16),
          const Text('Custom Dialog', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Anuluj'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
```

## Powiadomienia

### 1. SnackBar - Powiadomienie na dole ekranu
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
    duration: const Duration(seconds: 3),
  ),
);
```

## Przekazywanie danych między ekranami

### 1. Przekazywanie danych do nowego ekranu
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailScreen(
      title: 'Tytuł',
      data: someData,
    ),
  ),
);
```

### 2. Otrzymywanie danych z poprzedniego ekranu
```dart
final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const InputScreen(),
  ),
);

if (result != null) {
  print('Otrzymano: $result');
}
```

### 3. Przekazywanie różnych typów wartości
```dart
// Zwracanie stringa
Navigator.pop(context, 'Sukces!');

// Zwracanie liczby
Navigator.pop(context, 42);

// Zwracanie obiektu
Navigator.pop(context, {'name': 'Jan', 'age': 25});

// Zwracanie null
Navigator.pop(context);

// Odbieranie z sprawdzeniem typu
final result = await Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ValueSenderScreen()),
);

if (result is String) {
  print('Otrzymano string: $result');
} else if (result is int) {
  print('Otrzymano liczbę: $result');
} else if (result is Map) {
  print('Otrzymano mapę: $result');
}
```

## Named Routes (opcjonalne)

### 1. Definicja routes w MaterialApp
```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomeScreen(),
    '/details': (context) => const DetailScreen(),
  },
)
```

### 2. Nawigacja z named routes
```dart
Navigator.pushNamed(context, '/details');
Navigator.pushReplacementNamed(context, '/home');
```

## Wskazówki i best practices

1. **Navigator.push()** - Używaj gdy chcesz zachować możliwość powrotu
2. **Navigator.pushReplacement()** - Używaj przy logowaniu/wylogowaniu
3. **Navigator.pushAndRemoveUntil()** - Używaj gdy chcesz "zresetować" nawigację
4. **Modal Bottom Sheet** - Idealny do opcji i akcji
5. **Dialogi** - Używaj do potwierdzeń i informacji
6. **SnackBar** - Idealny do krótkich powiadomień
7. **Zawsze sprawdzaj wynik Navigator.pop()** jeśli oczekujesz wartości zwrotnej
8. **Używaj const konstruktorów** gdzie to możliwe dla lepszej wydajności

