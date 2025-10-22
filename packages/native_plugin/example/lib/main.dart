import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:native_plugin/native_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Plugin Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const NativePluginDemo(),
    );
  }
}

class NativePluginDemo extends StatefulWidget {
  const NativePluginDemo({super.key});

  @override
  State<NativePluginDemo> createState() => _NativePluginDemoState();
}

class _NativePluginDemoState extends State<NativePluginDemo> {
  final _nativePlugin = NativePlugin();
  
  // Method Channel Demo State
  String _platformVersion = 'Unknown';
  int _calculationResult = 0;
  Map<String, dynamic> _deviceInfo = {};
  
  // Event Channel Demo State
  StreamSubscription<int>? _randomNumberSubscription;
  
  int _currentRandomNumber = 0;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  @override
  void dispose() {
    _randomNumberSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initPlatformState() async {
    try {
      final version = await _nativePlugin.getPlatformVersion() ?? 'Unknown platform version';
      if (mounted) {
        setState(() {
          _platformVersion = version;
        });
      }
    } on PlatformException {
      if (mounted) {
        setState(() {
          _platformVersion = 'Failed to get platform version.';
        });
      }
    }
  }

  // Method Channel Examples
  
  Future<void> _calculateSum() async {
    try {
      final result = await _nativePlugin.calculateSum(15, 25);
      if (mounted) {
        setState(() {
          _calculationResult = result;
        });
      }
    } on PlatformException catch (e) {
      _showErrorSnackBar('Calculation failed: ${e.message}');
    }
  }

  Future<void> _getDeviceInfo() async {
    try {
      final info = await _nativePlugin.getDeviceInfo();
      if (mounted) {
        setState(() {
          _deviceInfo = info;
        });
      }
    } on PlatformException catch (e) {
      _showErrorSnackBar('Failed to get device info: ${e.message}');
    }
  }

  // Event Channel Examples
  
  void _startRandomNumberStream() {
    _randomNumberSubscription?.cancel();
    _randomNumberSubscription = _nativePlugin.getRandomNumberStream().listen(
      (number) {
        if (mounted) {
          setState(() {
            _currentRandomNumber = number;
          });
        }
      },
      onError: (error) {
        _showErrorSnackBar('Random number stream error: $error');
      },
    );
  }

  void _stopRandomNumberStream() {
    _randomNumberSubscription?.cancel();
    _randomNumberSubscription = null;
  }


  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Plugin Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Platform Version
            _buildInfoCard(
              'Platform Version',
              _platformVersion,
              const Icon(Icons.info),
            ),
            
            const SizedBox(height: 20),
            
            // Method Channel Examples
            _buildSectionTitle('Method Channel Examples'),
            
            // Calculation Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Calculate Sum (15 + 25)',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Result: $_calculationResult'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _calculateSum,
                      child: const Text('Calculate'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Device Info Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Device Information',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _getDeviceInfo,
                      child: const Text('Get Device Info'),
                    ),
                    if (_deviceInfo.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text('Device Info: ${_deviceInfo.toString()}'),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Event Channel Examples
            _buildSectionTitle('Event Channel Examples'),
            
            // Random Number Stream
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Random Number Stream',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Current Number: $_currentRandomNumber'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _startRandomNumberStream,
                          child: const Text('Start Stream'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _stopRandomNumberStream,
                          child: const Text('Stop Stream'),
                        ),
                      ],
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Icon icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(value),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
