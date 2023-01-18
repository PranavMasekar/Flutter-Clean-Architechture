import 'package:clean_tdd/core/error/failures.dart';
import 'package:clean_tdd/core/usecases/usecase.dart';
import 'package:clean_tdd/features/trivia/domain/entities/number_trivia.dart';
import 'package:clean_tdd/features/trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, int> {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia({required this.numberTriviaRepository});

  @override
  Future<Either<Failure, NumberTrivia>> call(int number) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}
