import 'package:clean_tdd/core/platform/network_info.dart';
import 'package:clean_tdd/features/trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_tdd/features/trivia/data/datasources/number_trivia_remote_data_source.dart';
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
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int num) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
