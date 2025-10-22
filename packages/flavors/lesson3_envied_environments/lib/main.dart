import 'package:flutter/material.dart';
import 'config/app_config.dart';

void main() {
  // Konfiguracja jest automatycznie ładowana z Envied + dart-define
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
              color: Colors.purple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How to Run with Envied + Dart Define',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Generate env files:\n'
                      '   dart run build_runner build\n\n'
                      '2. Run with different environments:\n'
                      '   Development: flutter run --dart-define=ENVIRONMENT=dev\n'
                      '   Staging: flutter run --dart-define=ENVIRONMENT=staging\n'
                      '   Production: flutter run --dart-define=ENVIRONMENT=prod\n\n'
                      '3. Build for different environments:\n'
                      '   flutter build apk --dart-define=ENVIRONMENT=prod',
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Benefits Card
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Benefits of Envied',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '✅ Type-safe environment variables\n'
                      '✅ Compile-time validation\n'
                      '✅ Automatic code generation\n'
                      '✅ IDE support with autocomplete\n'
                      '✅ No runtime errors for missing variables\n'
                      '✅ Secure - variables are obfuscated',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}