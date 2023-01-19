import 'dart:convert';

import 'package:clean_tdd/core/error/exceptions.dart';
import 'package:clean_tdd/features/trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel trivia);
}

class NumberTriviaLocalDataSourceImpl extends NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel trivia) async {
    sharedPreferences.setString(
      "CACHED_NUMBER_TRIVIA",
      json.encode(trivia.toJson()),
    );
  }

  @override
  Future<NumberTriviaModel> getLastTrivia() async {
    final jsonString = sharedPreferences.getString("CACHED_NUMBER_TRIVIA");
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
