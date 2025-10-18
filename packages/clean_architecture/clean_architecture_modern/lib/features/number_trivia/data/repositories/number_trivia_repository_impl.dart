import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../datasources/number_trivia_local_data_source.dart';
import '../datasources/number_trivia_remote_data_source.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecases/usecase.dart';

/// Implementation of NumberTriviaRepository
class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource _remoteDataSource;
  final NumberTriviaLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  
  const NumberTriviaRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );
  
  @override
  Future<UseCaseResult<NumberTrivia>> getConcreteNumberTrivia(int number) async {
    try {
      if (await _networkInfo.isConnected) {
        // Get from remote source
        final remoteTrivia = await _remoteDataSource.getConcreteNumberTrivia(number);
        
        // Cache the result
        await _localDataSource.cacheNumberTrivia(remoteTrivia);
        
        return UseCaseSuccess(remoteTrivia.toEntity());
      } else {
        // Get from local cache
        final localTrivia = await _localDataSource.getLastNumberTrivia();
        return UseCaseSuccess(localTrivia.toEntity());
      }
    } on ServerException catch (e) {
      return UseCaseFailure(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return UseCaseFailure(NetworkFailure(e.message));
    } on CacheException catch (e) {
      return UseCaseFailure(CacheFailure(e.message));
    } catch (e) {
      return UseCaseFailure(UnknownFailure('Unexpected error: $e'));
    }
  }
  
  @override
  Future<UseCaseResult<NumberTrivia>> getRandomNumberTrivia() async {
    try {
      if (await _networkInfo.isConnected) {
        // Get from remote source
        final remoteTrivia = await _remoteDataSource.getRandomNumberTrivia();
        
        // Cache the result
        await _localDataSource.cacheNumberTrivia(remoteTrivia);
        
        return UseCaseSuccess(remoteTrivia.toEntity());
      } else {
        // Get from local cache
        final localTrivia = await _localDataSource.getLastNumberTrivia();
        return UseCaseSuccess(localTrivia.toEntity());
      }
    } on ServerException catch (e) {
      return UseCaseFailure(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return UseCaseFailure(NetworkFailure(e.message));
    } on CacheException catch (e) {
      return UseCaseFailure(CacheFailure(e.message));
    } catch (e) {
      return UseCaseFailure(UnknownFailure('Unexpected error: $e'));
    }
  }
}
