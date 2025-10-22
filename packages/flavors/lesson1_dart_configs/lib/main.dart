import 'package:flavors_lesson1/config/config_prod.dart';
import 'package:flavors_lesson1/config/config_staging.dart';
import 'package:flutter/material.dart';
import 'config/app_config.dart';
import 'config/config_dev.dart'; // Zmień na config_prod.dart lub config_staging.dart

void main() {
  // Wybierz konfigurację - zmień import powyżej!
  // final config = DevConfig();
  final config = StagingConfig();
  // final config = ProdConfig();

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
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How to Switch Environment',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Go to lib/main.dart\n'
                      '2. Change the import:\n'
                      '   - Dev: import \'config/config_dev.dart\'\n'
                      '   - Staging: import \'config/config_staging.dart\'\n'
                      '   - Prod: import \'config/config_prod.dart\'\n'
                      '3. Change the config instantiation:\n'
                      '   - Dev: DevConfig()\n'
                      '   - Staging: StagingConfig()\n'
                      '   - Prod: ProdConfig()\n'
                      '4. Hot reload the app',
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