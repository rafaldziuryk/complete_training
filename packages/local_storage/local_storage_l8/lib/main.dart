import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage L8 - Drift',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  PageState createState() => PageState();
}

class PageState extends State<Page> {
  late AppDatabase _database;
  List<Counter> _counters = [];
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = AppDatabase();
    
    // Load initial data
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _loadCounters();
    });
  }

  Future<void> _loadCounters() async {
    final counters = await _database.getAllCounters();
    final total = await _database.getTotalCount();
    
    setState(() {
      _counters = counters;
      _totalCount = total;
    });
  }

  Future<void> _addCounter() async {
    final newValue = _counters.isEmpty ? 1 : (_counters.last.value + 1);
    await _database.insertCounter(newValue);
    await _loadCounters();
  }

  Future<void> _incrementCounter(int id) async {
    final counter = _counters.firstWhere((c) => c.id == id);
    await _database.updateCounter(id, counter.value + 1);
    await _loadCounters();
  }

  Future<void> _decrementCounter(int id) async {
    final counter = _counters.firstWhere((c) => c.id == id);
    await _database.updateCounter(id, counter.value - 1);
    await _loadCounters();
  }

  Future<void> _deleteCounter(int id) async {
    await _database.deleteCounter(id);
    await _loadCounters();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drift Database Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Total count display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              children: [
                Text(
                  'Total Count',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '$_totalCount',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Counters list
          Expanded(
            child: _counters.isEmpty
                ? const Center(
                    child: Text(
                      'No counters yet.\nTap + to add one!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _counters.length,
                    itemBuilder: (context, index) {
                      final counter = _counters[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: Text(
                              '${counter.id}',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            'Counter ${counter.id}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Value: ${counter.value}\nCreated: ${_formatDate(counter.createdAt)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => _decrementCounter(counter.id),
                                icon: const Icon(Icons.remove),
                                color: Colors.red,
                              ),
                              Text(
                                '${counter.value}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () => _incrementCounter(counter.id),
                                icon: const Icon(Icons.add),
                                color: Colors.green,
                              ),
                              IconButton(
                                onPressed: () => _deleteCounter(counter.id),
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCounter,
        tooltip: 'Add Counter',
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}