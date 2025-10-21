import 'package:dio/dio.dart';
import '../models/number_trivia_model.dart';
import '../../../../core/error/exceptions.dart';

/// Abstract class for remote data source
abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

/// Implementation of remote data source using Dio
class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Dio _dio;
  
  const NumberTriviaRemoteDataSourceImpl(this._dio);
  
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    try {
      final response = await _dio.get('https://complete-training.onrender.com/exact/$number');
      
      if (response.statusCode == 200) {
        return NumberTriviaModel.fromJson({
          'text': response.data,
          'number': number,
        });
      } else {
        throw const ServerException('Failed to load number trivia');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException('No internet connection');
      }
      throw ServerException('Server error: ${e.message}');
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
  
  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    try {
      final response = await _dio.get('https://complete-training.onrender.com/random');
      
      if (response.statusCode == 200) {
        return NumberTriviaModel.fromJson({
          'text': response.data,
          'number': 0, // Random number trivia doesn't have a specific number
        });
      } else {
        throw const ServerException('Failed to load random number trivia');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException('No internet connection');
      }
      throw ServerException('Server error: ${e.message}');
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
