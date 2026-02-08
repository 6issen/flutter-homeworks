import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// --- События (Events) ---
sealed class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  final String email;
  const LoginEmailChanged(this.email);
  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  const LoginPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class LoginFormSubmitted extends LoginEvent {
  const LoginFormSubmitted();
}

enum FormStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final String email;
  final String password;
  final FormStatus status;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = FormStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  bool get isValidEmail => email.contains('@') && email.length > 3;
  bool get isValidPassword => password.length >= 6;

  @override
  List<Object?> get props => [email, password, status, errorMessage];
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, status: FormStatus.initial));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, status: FormStatus.initial));
    });

    on<LoginFormSubmitted>((event, emit) async {
      if (!state.isValidEmail || !state.isValidPassword) {
        emit(state.copyWith(status: FormStatus.failure, errorMessage: 'Некорректные данные'));
        return;
      }

      emit(state.copyWith(status: FormStatus.loading));

      try {
        await Future.delayed(const Duration(seconds: 2));

        if (state.password == 'error') {
          throw Exception('Ошибка сервера 500');
        }

        emit(state.copyWith(status: FormStatus.success));
      } catch (e) {
        emit(state.copyWith(status: FormStatus.failure, errorMessage: e.toString()));
      }
    });
  }
}