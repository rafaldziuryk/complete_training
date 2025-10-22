# Go Router Demo

Przykładowa lekcja pokazująca nawigację z wykorzystaniem biblioteki go_router w Flutter.

## Opis

Ta aplikacja demonstruje zaawansowane funkcje nawigacji z go_router:

### Podstawowe funkcje:
- **Named Routes** - Nawigacja z nazwanymi trasami
- **Path Parameters** - Przekazywanie parametrów przez ścieżkę URL
- **Query Parameters** - Przekazywanie parametrów przez query string
- **Nested Routes** - Zagnieżdżone trasy
- **Redirect Logic** - Logika przekierowań
- **Error Handling** - Obsługa błędów nawigacji

### Zaawansowane funkcje:
- **Route Guards** - Ochrona tras wymagających autoryzacji
- **Deep Linking** - Obsługa głębokich linków
- **State Management** - Zarządzanie stanem nawigacji
- **Custom Transitions** - Niestandardowe animacje przejść

## Struktura projektu

```
lib/
├── main.dart                           # Konfiguracja routera i punkt wejścia
└── screens/
    ├── home_screen.dart               # Główny ekran z przyciskami nawigacji
    ├── profile_screen.dart            # Ekran profilu z query parameters
    ├── settings_screen.dart           # Ekran ustawień
    ├── user_detail_screen.dart        # Ekran szczegółów użytkownika (path params)
    ├── user_edit_screen.dart          # Nested route dla edycji użytkownika
    ├── login_screen.dart              # Ekran logowania (redirect logic)
    ├── protected_screen.dart          # Chroniony ekran
    ├── nested_example_screen.dart     # Przykład nested routes
    ├── nested_tab1_screen.dart        # Pierwszy nested route
    ├── nested_tab2_screen.dart        # Drugi nested route
    └── error_screen.dart              # Ekran błędów
```

## Jak uruchomić

1. Przejdź do folderu `packages/navigation/go_router`
2. Uruchom `flutter pub get`
3. Uruchom `flutter run`

## Przykłady użycia

### 1. Podstawowa nawigacja z named routes
```dart
// Nawigacja do profilu
context.goNamed('profile');

// Nawigacja do ustawień
context.goNamed('settings');
```

### 2. Path Parameters
```dart
// Nawigacja z parametrem w ścieżce
context.goNamed('user-detail', pathParameters: {'userId': '123'});

// URL: /user/123
```

### 3. Query Parameters
```dart
// Nawigacja z parametrami query
context.goNamed('profile', queryParameters: {
  'name': 'John Doe',
  'age': '25',
  'city': 'Warsaw',
});

// URL: /profile?name=John%20Doe&age=25&city=Warsaw
```

### 4. Nested Routes
```dart
// Nawigacja do nested route
context.goNamed('user-edit', pathParameters: {'userId': '123'});

// URL: /user/123/edit
```

### 5. Redirect Logic
```dart
// W konfiguracji routera
redirect: (context, state) {
  final isLoggedIn = false; // Sprawdź stan autoryzacji
  final isLoggingIn = state.matchedLocation == '/login';
  
  if (!isLoggedIn && !isLoggingIn) {
    return '/login'; // Przekieruj do logowania
  }
  
  return null; // Brak przekierowania
},
```

### 6. Error Handling
```dart
// W konfiguracji routera
errorBuilder: (context, state) => ErrorScreen(
  error: state.error.toString(),
),
```

## Konfiguracja Routera

### Podstawowa konfiguracja
```dart
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  
  // Error handling
  errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),
  
  // Redirect logic
  redirect: (context, state) {
    // Logika przekierowań
    return null;
  },
  
  routes: [
    // Definicje tras
  ],
);
```

### Definicja tras
```dart
GoRoute(
  path: '/user/:userId',
  name: 'user-detail',
  builder: (context, state) {
    final userId = state.pathParameters['userId']!;
    return UserDetailScreen(userId: userId);
  },
  routes: [
    // Nested routes
    GoRoute(
      path: 'edit',
      name: 'user-edit',
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        return UserEditScreen(userId: userId);
      },
    ),
  ],
),
```

## Funkcje demonstracyjne

### 1. Home Screen
- Przyciski do wszystkich typów nawigacji
- Podzielone na kategorie funkcjonalne
- Interaktywne przykłady

### 2. Profile Screen
- Demonstruje query parameters
- Wyświetla przekazane parametry
- Możliwość odświeżenia z nowymi parametrami

### 3. User Detail Screen
- Demonstruje path parameters
- Wyświetla ID użytkownika z URL
- Link do nested route (edycja)

### 4. User Edit Screen
- Przykład nested route
- Formularz edycji
- Nawigacja wstecz

### 5. Login Screen
- Demonstruje redirect logic
- Symulacja procesu logowania
- Przekierowanie po zalogowaniu

### 6. Protected Screen
- Przykład chronionej trasy
- Wymaga autoryzacji
- Demonstruje route guards

### 7. Nested Routes
- Przykład zagnieżdżonych tras
- Tab 1 i Tab 2
- Nawigacja między nested routes

## Kluczowe różnice między go_router a Navigator

| Funkcja | Navigator | go_router |
|---------|-----------|-----------|
| **Typ nawigacji** | Imperatywna | Deklaratywna |
| **URL Support** | Brak | Pełne wsparcie |
| **Deep Linking** | Ograniczone | Natywne |
| **State Management** | Manualne | Automatyczne |
| **Type Safety** | Ograniczone | Pełne |
| **Web Support** | Podstawowe | Zaawansowane |

## Wskazówki i best practices

1. **Używaj named routes** - Łatwiejsze w utrzymaniu niż bezpośrednie ścieżki
2. **Path parameters dla ID** - Używaj dla identyfikatorów zasobów
3. **Query parameters dla filtrów** - Używaj dla opcjonalnych parametrów
4. **Nested routes dla hierarchii** - Organizuj trasy w logiczne grupy
5. **Redirect logic dla autoryzacji** - Centralizuj logikę przekierowań
6. **Error handling** - Zawsze obsługuj błędy nawigacji
7. **Type safety** - Wykorzystuj typowanie dla parametrów tras

## Testowanie

Aplikacja zawiera interaktywne przykłady wszystkich funkcji go_router. Kliknij na przyciski aby zobaczyć różne zachowania w akcji.

### Testowanie deep linking:
- Skopiuj URL z aplikacji
- Wklej w przeglądarce (web)
- Sprawdź czy aplikacja otwiera się na odpowiednim ekranie

### Testowanie redirect logic:
- Spróbuj przejść do chronionego ekranu
- Zauważ automatyczne przekierowanie do logowania

## Następne kroki

Po przetestowaniu podstawowych funkcji go_router, możesz:
1. Dodać własne trasy
2. Implementować zaawansowaną autoryzację
3. Dodać custom transitions
4. Implementować state management
5. Dodać testy jednostkowe dla routera