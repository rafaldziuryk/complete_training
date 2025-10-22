import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/screens/home_screen.dart';
import 'package:go_router_demo/screens/profile_screen.dart';
import 'package:go_router_demo/screens/settings_screen.dart';
import 'package:go_router_demo/screens/user_detail_screen.dart';
import 'package:go_router_demo/screens/user_edit_screen.dart';
import 'package:go_router_demo/screens/nested_example_screen.dart';
import 'package:go_router_demo/screens/nested_tab1_screen.dart';
import 'package:go_router_demo/screens/nested_tab2_screen.dart';
import 'package:go_router_demo/screens/protected_screen.dart';
import 'package:go_router_demo/screens/login_screen.dart';
import 'package:go_router_demo/screens/error_screen.dart';

// Global router instance
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  
  // Error handling
  errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),
  
  // Redirect logic
  redirect: (context, state) {
    // Przykład: przekierowanie do logowania jeśli użytkownik nie jest zalogowany
    // W prawdziwej aplikacji sprawdzalibyśmy stan autoryzacji
    const isLoggedIn = false; // Symulacja - zawsze false dla demonstracji
    final isLoggingIn = state.matchedLocation == '/login';
    
    if (!isLoggedIn && !isLoggingIn) {
      return '/login';
    }
    
    return null; // Brak przekierowania
  },
  
  routes: [
    // Home route
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    
    // Login route
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    
    // Profile route
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    
    // Settings route
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    
    // User detail route with path parameter
    GoRoute(
      path: '/user/:userId',
      name: 'user-detail',
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        return UserDetailScreen(userId: userId);
      },
      routes: [
        // Nested route for editing user
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
    
    // Protected route (wymaga autoryzacji)
    GoRoute(
      path: '/protected',
      name: 'protected',
      builder: (context, state) => const ProtectedScreen(),
    ),
    
    // Nested routes example
    GoRoute(
      path: '/nested',
      name: 'nested',
      builder: (context, state) => const NestedExampleScreen(),
      routes: [
        GoRoute(
          path: 'tab1',
          name: 'nested-tab1',
          builder: (context, state) => const NestedTab1Screen(),
        ),
        GoRoute(
          path: 'tab2',
          name: 'nested-tab2',
          builder: (context, state) => const NestedTab2Screen(),
        ),
      ],
    ),
  ],
);

void main() {
  runApp(const GoRouterDemoApp());
}

class GoRouterDemoApp extends StatelessWidget {
  const GoRouterDemoApp({super.key});

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