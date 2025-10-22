import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/number_trivia_model.dart';
import '../../../../core/error/exceptions.dart';

/// Abstract class for local data source
abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

/// Implementation of local data source using SharedPreferences
class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences _sharedPreferences;
  
  const NumberTriviaLocalDataSourceImpl(this._sharedPreferences);
  
  static const String cachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';
  
  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = _sharedPreferences.getString(cachedNumberTrivia);
    
    if (jsonString != null) {
      try {
        final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        return NumberTriviaModel.fromJson(jsonMap);
      } catch (e) {
        throw const CacheException('Failed to parse cached data');
      }
    } else {
      throw const CacheException('No cached data found');
    }
  }
  
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    try {
      final jsonString = jsonEncode(triviaToCache.toJson());
      await _sharedPreferences.setString(cachedNumberTrivia, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache data: $e');
    }
  }
}
