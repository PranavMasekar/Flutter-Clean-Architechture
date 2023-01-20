import 'package:clean_tdd/features/trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_tdd/features/trivia/presentation/widgets/widgets.dart';
import 'package:clean_tdd/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia"),
      ),
      body: BlocProvider(
        create: (context) => locator<NumberTriviaBloc>(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return const MessageDisplay(
                        message: 'Start searching!',
                      );
                    } else if (state is Loading) {
                      return const LoadingWidget();
                    } else if (state is Loaded) {
                      return TriviaDisplay(
                        numberTrivia: state.trivia,
                      );
                    } else if (state is Error) {
                      return MessageDisplay(
                        message: state.errorMsg,
                      );
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: const Placeholder(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const TriviaControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
