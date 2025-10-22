import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../network/network_info.dart';
import '../util/input_converter.dart';
import '../../features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import '../../features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import '../../features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import '../../features/number_trivia/domain/repositories/number_trivia_repository.dart';
import '../../features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import '../../features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import '../../features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final GetIt sl = GetIt.instance;

/// Initialize all dependencies
Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InputConverter());
  
  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sl()),
  );
  
  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      sl(),
      sl(),
      sl(),
    ),
  );
  
  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));
  
  // BLoC
  sl.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl(),
    ),
  );
}
