# Przykłady kodu - Go Router

## Podstawowa konfiguracja

### 1. Router Configuration
```dart
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  
  // Error handling
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error.toString(),
  ),
  
  // Redirect logic
  redirect: (context, state) {
    final isLoggedIn = false; // Sprawdź stan autoryzacji
    final isLoggingIn = state.matchedLocation == '/login';
    
    if (!isLoggedIn && !isLoggingIn) {
      return '/login';
    }
    
    return null; // Brak przekierowania
  },
  
  routes: [
    // Definicje tras
  ],
);
```

### 2. MaterialApp.router Setup
```dart
class GoRouterDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Go Router Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
```

## Podstawowe metody nawigacji

### 1. Named Routes - Podstawowa nawigacja
```dart
// Nawigacja do profilu
context.goNamed('profile');

// Nawigacja do ustawień
context.goNamed('settings');

// Nawigacja do home
context.goNamed('home');
```

### 2. Path Parameters - Parametry w ścieżce
```dart
// Nawigacja z parametrem userId
context.goNamed('user-detail', pathParameters: {
  'userId': '123',
});

// URL: /user/123

// Nawigacja z wieloma parametrami
context.goNamed('product-detail', pathParameters: {
  'categoryId': 'electronics',
  'productId': 'laptop-123',
});

// URL: /category/electronics/product/laptop-123
```

### 3. Query Parameters - Parametry query string
```dart
// Nawigacja z query parameters
context.goNamed('profile', queryParameters: {
  'name': 'John Doe',
  'age': '25',
  'city': 'Warsaw',
});

// URL: /profile?name=John%20Doe&age=25&city=Warsaw

// Nawigacja z filtrami
context.goNamed('products', queryParameters: {
  'category': 'electronics',
  'price_min': '100',
  'price_max': '1000',
  'sort': 'price_asc',
});

// URL: /products?category=electronics&price_min=100&price_max=1000&sort=price_asc
```

### 4. Nested Routes - Zagnieżdżone trasy
```dart
// Nawigacja do nested route
context.goNamed('user-edit', pathParameters: {
  'userId': '123',
});

// URL: /user/123/edit

// Nawigacja do głęboko zagnieżdżonej trasy
context.goNamed('user-settings-privacy', pathParameters: {
  'userId': '123',
});

// URL: /user/123/settings/privacy
```

## Definicja tras

### 1. Podstawowa trasa
```dart
GoRoute(
  path: '/profile',
  name: 'profile',
  builder: (context, state) => const ProfileScreen(),
),
```

### 2. Trasa z path parameters
```dart
GoRoute(
  path: '/user/:userId',
  name: 'user-detail',
  builder: (context, state) {
    final userId = state.pathParameters['userId']!;
    return UserDetailScreen(userId: userId);
  },
),
```

### 3. Trasa z nested routes
```dart
GoRoute(
  path: '/user/:userId',
  name: 'user-detail',
  builder: (context, state) {
    final userId = state.pathParameters['userId']!;
    return UserDetailScreen(userId: userId);
  },
  routes: [
    GoRoute(
      path: 'edit',
      name: 'user-edit',
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        return UserEditScreen(userId: userId);
      },
    ),
    GoRoute(
      path: 'settings',
      name: 'user-settings',
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        return UserSettingsScreen(userId: userId);
      },
      routes: [
        GoRoute(
          path: 'privacy',
          name: 'user-settings-privacy',
          builder: (context, state) {
            final userId = state.pathParameters['userId']!;
            return UserPrivacyScreen(userId: userId);
          },
        ),
      ],
    ),
  ],
),
```

### 4. Trasa z redirect
```dart
GoRoute(
  path: '/admin',
  name: 'admin',
  builder: (context, state) => const AdminScreen(),
  redirect: (context, state) {
    final isAdmin = checkAdminStatus(); // Twoja logika
    if (!isAdmin) {
      return '/unauthorized';
    }
    return null;
  },
),
```

## Pobieranie parametrów

### 1. Path Parameters
```dart
class UserDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = GoRouterState.of(context).pathParameters['userId']!;
    
    return Scaffold(
      appBar: AppBar(title: Text('User $userId')),
      body: Text('User ID: $userId'),
    );
  }
}
```

### 2. Query Parameters
```dart
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final queryParams = GoRouterState.of(context).uri.queryParameters;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Column(
        children: [
          if (queryParams.containsKey('name'))
            Text('Name: ${queryParams['name']}'),
          if (queryParams.containsKey('age'))
            Text('Age: ${queryParams['age']}'),
        ],
      ),
    );
  }
}
```

### 3. Extra Data (przekazywanie obiektów)
```dart
// Nawigacja z extra data
context.goNamed('user-detail', 
  pathParameters: {'userId': '123'},
  extra: UserModel(id: '123', name: 'John Doe'),
);

// Odbieranie extra data
class UserDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = GoRouterState.of(context).extra as UserModel?;
    
    return Scaffold(
      appBar: AppBar(title: Text(user?.name ?? 'User')),
      body: Text('User: ${user?.name}'),
    );
  }
}
```

## Redirect Logic

### 1. Globalny redirect
```dart
final GoRouter appRouter = GoRouter(
  redirect: (context, state) {
    // Sprawdź autoryzację
    final isLoggedIn = AuthService.isLoggedIn();
    final isLoggingIn = state.matchedLocation == '/login';
    
    if (!isLoggedIn && !isLoggingIn) {
      return '/login';
    }
    
    // Sprawdź uprawnienia dla chronionych tras
    if (state.matchedLocation.startsWith('/admin')) {
      final isAdmin = AuthService.isAdmin();
      if (!isAdmin) {
        return '/unauthorized';
      }
    }
    
    return null; // Brak przekierowania
  },
  routes: [...],
);
```

### 2. Redirect dla konkretnej trasy
```dart
GoRoute(
  path: '/profile',
  name: 'profile',
  builder: (context, state) => const ProfileScreen(),
  redirect: (context, state) {
    final user = AuthService.getCurrentUser();
    if (user == null) {
      return '/login';
    }
    return null;
  },
),
```

## Error Handling

### 1. Globalny error builder
```dart
final GoRouter appRouter = GoRouter(
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error.toString(),
  ),
  routes: [...],
);
```

### 2. Custom error screen
```dart
class ErrorScreen extends StatelessWidget {
  final String error;
  
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.goNamed('home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Advanced Features

### 1. Custom Transitions
```dart
GoRoute(
  path: '/profile',
  name: 'profile',
  pageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    child: const ProfileScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
        ),
        child: child,
      );
    },
  ),
),
```

### 2. Route Guards z Future
```dart
GoRoute(
  path: '/admin',
  name: 'admin',
  builder: (context, state) => const AdminScreen(),
  redirect: (context, state) async {
    final isAdmin = await AuthService.checkAdminStatus();
    if (!isAdmin) {
      return '/unauthorized';
    }
    return null;
  },
),
```

### 3. Conditional Routes
```dart
final GoRouter appRouter = GoRouter(
  routes: [
    // Podstawowe trasy
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    
    // Trasy tylko dla zalogowanych użytkowników
    if (AuthService.isLoggedIn()) ...[
      GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    ],
    
    // Trasy tylko dla administratorów
    if (AuthService.isAdmin()) ...[
      GoRoute(path: '/admin', builder: (context, state) => const AdminScreen()),
    ],
  ],
);
```

## Best Practices

1. **Używaj named routes** - Łatwiejsze w utrzymaniu
2. **Path parameters dla ID** - Używaj dla identyfikatorów zasobów
3. **Query parameters dla filtrów** - Używaj dla opcjonalnych parametrów
4. **Nested routes dla hierarchii** - Organizuj trasy w logiczne grupy
5. **Centralizuj redirect logic** - Używaj globalnego redirect
6. **Obsługuj błędy** - Zawsze implementuj error builder
7. **Type safety** - Wykorzystuj typowanie dla parametrów
8. **Testuj deep linking** - Sprawdź czy URL działają poprawnie
9. **Dokumentuj trasy** - Utrzymuj dokumentację tras
10. **Używaj const gdzie możliwe** - Poprawia wydajność



