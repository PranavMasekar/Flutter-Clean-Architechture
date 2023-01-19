import 'package:clean_tdd/features/trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel trivia);
}
