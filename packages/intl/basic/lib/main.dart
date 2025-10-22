import 'package:flutter/material.dart';

import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? overrideLocale;

  void changeLanguage(Locale? locale) {
    setState(() {
      print('rfl cl');
      overrideLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Builder(builder: (context) => MyHomePage()),
      locale: overrideLocale,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
        actions: [
          // Polish language button
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => MyApp.of(context)?.changeLanguage(const Locale('pl')),
                icon: Text(S.of(context).polish),
              );
            },
          ),
          // English language button
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => MyApp.of(context)?.changeLanguage(const Locale('en')),
                icon: Text(S.of(context).english),
              );
            },
          ),
          // Reset to system language
          IconButton(
            onPressed: () => MyApp.of(context)?.changeLanguage(null),
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Current language info
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(S.of(context).currentLanguage),
                    const SizedBox(height: 8),
                    Text(
                      MyApp.of(context)?.overrideLocale?.languageCode ??
                          'System (${Localizations.localeOf(context).languageCode})',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(S.of(context).incrementLabel),
            Text('$_counter', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
