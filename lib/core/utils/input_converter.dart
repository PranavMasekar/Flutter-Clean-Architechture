import 'package:clean_tdd/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, int> stringToInt(String str) {
    try {
      final int num = int.parse(str);
      if (num < 0) {
        throw const FormatException();
      } else {
        return Right(num);
      }
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
