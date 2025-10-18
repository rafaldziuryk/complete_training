import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/number_trivia_bloc.dart';
import '../bloc/number_trivia_state.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/trivia_display.dart';
import '../widgets/trivia_controls.dart';

/// Main page for number trivia
class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
        centerTitle: true,
      ),
      body: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          return switch (state) {
            NumberTriviaInitial() => const MessageDisplay(
                message: 'Start searching!',
              ),
            NumberTriviaLoading() => const LoadingWidget(),
            NumberTriviaLoaded(trivia: final trivia) => TriviaDisplay(
                trivia: trivia,
              ),
            NumberTriviaError(message: final message) => MessageDisplay(
                message: message,
              ),
          };
        },
      ),
      bottomNavigationBar: const TriviaControls(),
    );
  }
}
