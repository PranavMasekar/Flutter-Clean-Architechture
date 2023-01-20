import 'package:clean_tdd/core/error/exceptions.dart';
import 'package:clean_tdd/core/network/network_info.dart';
import 'package:clean_tdd/features/trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_tdd/features/trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_tdd/features/trivia/data/models/number_trivia_model.dart';
import 'package:clean_tdd/features/trivia/domain/entities/number_trivia.dart';
import 'package:clean_tdd/core/error/failures.dart';
import 'package:clean_tdd/features/trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource localDataSource;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int num) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(num);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    Future<NumberTriviaModel> Function() getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        await localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastTrivia();
        return Right(localTrivia);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }
}
