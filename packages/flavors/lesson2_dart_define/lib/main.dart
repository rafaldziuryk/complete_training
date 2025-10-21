import 'package:flutter/material.dart';
import 'config/app_config.dart';

void main() {
  // Konfiguracja jest automatycznie ładowana z dart-define
  final config = AppConfig.fromEnvironment();

  runApp(MyApp(config: config));
}

class MyApp extends StatelessWidget {
  final AppConfig config;

  const MyApp({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: ConfigScreen(config: config),
    );
  }
}

class ConfigScreen extends StatelessWidget {
  final AppConfig config;

  const ConfigScreen({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(config.appName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Environment Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Environment Information',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow('Environment', config.environment),
                      _buildInfoRow('API Base URL', config.apiBaseUrl),
                      _buildInfoRow('Logging Enabled', config.enableLogging.toString()),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // Instructions Card
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How to Run with Different Environments',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Development:\n'
                        'flutter run --dart-define=ENVIRONMENT=dev --dart-define=API_BASE_URL=https://api-dev.example.com --dart-define=ENABLE_LOGGING=true --dart-define=DEBUG_MENU_ENABLED=true\n\n'
                        'Staging:\n'
                        'flutter run --dart-define=ENVIRONMENT=staging --dart-define=API_BASE_URL=https://api-staging.example.com --dart-define=ENABLE_LOGGING=true\n\n'
                        'Production:\n'
                        'flutter run --dart-define=ENVIRONMENT=prod --dart-define=API_BASE_URL=https://api.example.com --dart-define=ENABLE_LOGGING=false',
                        style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Quick Commands Card
              Card(
                color: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Commands',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Dev: flutter run --dart-define=ENVIRONMENT=dev --dart-define=ENABLE_LOGGING=true\n'
                        'Staging: flutter run --dart-define=ENVIRONMENT=staging\n'
                        'Prod: flutter run --dart-define=ENVIRONMENT=prod --dart-define=ENABLE_LOGGING=false',
                        style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }
}
