import 'package:bloc/bloc.dart';
import 'package:clean_tdd/core/error/failures.dart';
import 'package:clean_tdd/core/usecases/usecase.dart';
import 'package:clean_tdd/core/utils/input_converter.dart';
import 'package:clean_tdd/features/trivia/domain/entities/number_trivia.dart';
import 'package:clean_tdd/features/trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_tdd/features/trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:equatable/equatable.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;
  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetNumberTriviaEvent>(_handleGetNumberTriviaEvent);
    on<GetRandomTiviaEvent>(_handleGetRandomTiviaEvent);
  }

  String getStringByFailure(Failure failure) {
    if (failure is ServerFailure) {
      return "Server failure";
    } else if (failure is CacheFailure) {
      return "Cache failure";
    } else {
      return "Unexpected Error";
    }
  }

  Future _handleGetNumberTriviaEvent(
      GetNumberTriviaEvent event, Emitter emit) async {
    final input = inputConverter.stringToInt(event.number);
    await input.fold(
      (error) {
        emit(const Error(errorMsg: "Invalid input"));
      },
      (n) async {
        emit(Loading());
        final failureOrTrivia = await getConcreteNumberTrivia(n);
        failureOrTrivia.fold(
          (failure) {
            emit(Error(errorMsg: getStringByFailure(failure)));
          },
          (trivia) {
            emit(Loaded(trivia: trivia));
          },
        );
      },
    );
  }

  Future _handleGetRandomTiviaEvent(
      GetRandomTiviaEvent event, Emitter emit) async {
    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    failureOrTrivia.fold(
      (failure) {
        emit(Error(errorMsg: getStringByFailure(failure)));
      },
      (trivia) {
        emit(Loaded(trivia: trivia));
      },
    );
  }
}
