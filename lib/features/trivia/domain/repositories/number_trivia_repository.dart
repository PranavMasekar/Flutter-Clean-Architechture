import 'package:clean_tdd/core/error/failures.dart';
import 'package:clean_tdd/features/trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int num);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
