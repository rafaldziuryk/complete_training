import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
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

class ConfigScreen extends StatefulWidget {
  final AppConfig config;
  
  const ConfigScreen({super.key, required this.config});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  String? _applicationId;
  String? _appName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAndroidInfo();
  }

  Future<void> _loadAndroidInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      
      setState(() {
        _applicationId = packageInfo.packageName;
        _appName = packageInfo.appName;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _applicationId = 'Error: $e';
        _appName = 'Error loading';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.config.appName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      _buildInfoRow('Environment', widget.config.environment),
                      _buildInfoRow('API Base URL', widget.config.apiBaseUrl),
                      _buildInfoRow('Logging Enabled', widget.config.enableLogging.toString()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Android Flavor Info Card
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Android Flavor Information (from System)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (_isLoading)
                        const Center(child: CircularProgressIndicator())
                      else ...[
                        _buildInfoRow('Real App ID', _applicationId ?? 'Loading...'),
                        _buildInfoRow('Real App Name', _appName ?? 'Loading...'),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text(
                            '💡 Te wartości są pobierane bezpośrednio z systemu Android przez package_info_plus i pokazują rzeczywisty applicationId z flavors!',
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                color: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How to Build with Android Flavors',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '1. Setup environment:\n'
                        '   ./scripts/setup.sh\n\n'
                        '2. Build for different environments:\n'
                        '   Development: ./scripts/build_dev.sh\n'
                        '   Staging: ./scripts/build_staging.sh\n'
                        '   Production: ./scripts/build_prod.sh\n\n'
                        '3. Each build will have:\n'
                        '   - Different app ID (com.example.flavorsdemo.dev/staging/prod)\n'
                        '   - Different app name\n'
                        '   - Different colors (Green/Orange/Blue)\n'
                        '   - Different configuration\n\n'
                        '4. Android flavors are configured in:\n'
                        '   android/app/build.gradle.kts',
                        style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
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
            width: 140,
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