// ignore_for_file: avoid_print
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc(int initialState) : super(initialState) {
    on<CounterEvent>((event, emit) {
      switch (event) {
        case CounterEvent.increment:
          emit(state + 1);
          break;
        case CounterEvent.decrement:
          emit(state - 1);
          break;
      }
    });
  }
}

void main() async {
  group('Counter', () {
    test('Bloc learn test increment', () async {
      var counterBloc = CounterBloc(0);

      var subscription = counterBloc.stream.listen((event) {
        expect(event, 1);
      });
      counterBloc.add(CounterEvent.increment);

      await Future.delayed(Duration.zero);
      await counterBloc.close();
    });

    test('Bloc learn test decrement', () async {
      var counterBloc = CounterBloc(0);

      var subscription = counterBloc.stream.listen((event) {
        expect(event, -1);
      });
      counterBloc.add(CounterEvent.decrement);

      await Future.delayed(Duration.zero);
      await counterBloc.close();
    });

    blocTest<CounterBloc, int>(
      'emits [int] when CounterEvent.increment is added.',
      build: () => CounterBloc(0),
      act: (bloc) => [
        bloc.add(CounterEvent.increment),
        bloc.add(CounterEvent.increment),
        bloc.add(CounterEvent.decrement),
      ],
      expect: () => [1, 2, 1],
    );
  });
}
