// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _DevEnv {
  static const List<int> _enviedkeyappName = <int>[
    198056959,
    2624064451,
    2416737636,
    3984259682,
    2483727498,
    2573902525,
    4263976685,
    2548287155,
    3690906388,
    682585536,
    1868283538,
    2468740357,
    922339917,
    213841426,
    2787606340,
    1065078570,
    1884702439,
    487731382,
  ];

  static const List<int> _envieddataappName = <int>[
    198056889,
    2624064431,
    2416737541,
    3984259604,
    2483727589,
    2573902543,
    4263976606,
    2548287123,
    3690906448,
    682585509,
    1868283647,
    2468740458,
    922339949,
    213841471,
    2787606372,
    1065078638,
    1884702370,
    487731424,
  ];

  static final String appName = String.fromCharCodes(List<int>.generate(
    _envieddataappName.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddataappName[i] ^ _enviedkeyappName[i]));

  static const String apiBaseUrl = 'https://api-dev.example.com';

  static const String environment = 'dev';

  static const bool enableLogging = true;
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _StagingEnv {
  static const String appName = 'Flavors Demo - STAGING';

  static const String apiBaseUrl = 'https://api-staging.example.com';

  static const String environment = 'staging';

  static const bool enableLogging = true;
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _ProdEnv {
  static const String appName = 'Flavors Demo - PROD';

  static const String apiBaseUrl = 'https://api.example.com';

  static const String environment = 'prod';

  static const bool enableLogging = false;
}
