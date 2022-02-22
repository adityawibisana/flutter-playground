// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit(int initialState) : super(initialState);

  void increment() {
    emit(state + 1);
  }

  void decrement() => emit(state - 1);
}

void main() async {
  test('Cubit learn test', () async {
    var counter = CounterCubit(0);
    counter.increment();
    expect(1, counter.state, reason: "Because 0 + 1 is 1");

    counter.decrement();
    expect(0, counter.state);
  });
}
