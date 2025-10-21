// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Application';

  @override
  String get incrementLabel => 'You have pushed the button this many times:';

  @override
  String get currentLanguage => 'Current Language:';
}
