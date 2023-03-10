part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetNumberTriviaEvent extends NumberTriviaEvent {
  final String number;

  const GetNumberTriviaEvent({required this.number});

  @override
  List<Object> get props => [number];
}

class GetRandomTiviaEvent extends NumberTriviaEvent {}
