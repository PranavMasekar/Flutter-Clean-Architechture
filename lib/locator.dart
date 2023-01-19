import 'package:clean_tdd/core/network/network_info.dart';
import 'package:clean_tdd/core/utils/input_converter.dart';
import 'package:clean_tdd/features/trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_tdd/features/trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_tdd/features/trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_tdd/features/trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_tdd/features/trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_tdd/features/trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_tdd/features/trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future<void> init() async {
  //! Features

  // Bloc
  locator.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: locator(),
      getRandomNumberTrivia: locator(),
      inputConverter: locator(),
    ),
  );

  // UseCases
  locator.registerLazySingleton(
    () => GetConcreteNumberTrivia(numberTriviaRepository: locator()),
  );
  locator.registerLazySingleton(
    () => GetRandomNumberTrivia(numberTriviaRepository: locator()),
  );

  // Repositories
  locator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // Data sources
  locator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: locator()),
  );

  //! Core
  locator.registerLazySingleton(() => InputConverter());
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: locator()),
  );

  //! External
  locator.registerFactoryAsync(() => SharedPreferences.getInstance());
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());
}
