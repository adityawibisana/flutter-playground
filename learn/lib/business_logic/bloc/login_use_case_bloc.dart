import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/const/states.dart';
import 'package:learn/data/repository/dio_network_client.dart';
import '../../const/events.dart';

class LoginEvent {
  final UserActionEvent event;
  final String username;
  final String password;

  LoginEvent({
    required this.event,
    required this.username,
    required this.password,
  });
}

class LoginUseCaseBloc extends Bloc<LoginEvent, ApiRequestState> {
  LoginUseCaseBloc(NetworkRepository networkRepository)
      : super(ApiRequestState.initial) {
    on<LoginEvent>((event, emit) async {
      switch (event.event) {
        case UserActionEvent.click:
          emit(ApiRequestState.loading);
          try {
            var login = await networkRepository.getToken(
              event.username,
              event.password,
            );
            if (login.accessToken.isNotEmpty) {
              emit(ApiRequestState.success);
            }
          } catch (exception) {
            emit(ApiRequestState.error);
          }
          break;
        case UserActionEvent.back:
          break;
        default:
          return;
      }
    });
  }
}
