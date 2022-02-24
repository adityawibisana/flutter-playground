import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/const/enums.dart';

class CounterActivationCubit extends Cubit<ActivationStatus> {
  int _clickCounter = 0;

  CounterActivationCubit({
    ActivationStatus initialState = ActivationStatus.deactivated,
  }) : super(initialState);

  void increment() {
    _clickCounter++;
    if (_clickCounter >= 10) {
      emit(ActivationStatus.activated);
    }
  }
}
