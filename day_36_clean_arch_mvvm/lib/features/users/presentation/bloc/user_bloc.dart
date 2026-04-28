import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_users_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;

  UserBloc({required this.getUsersUseCase}) : super(UserInitial()) {
    on<GetUsersEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await getUsersUseCase();
        emit(UserLoaded(users: users));
      } catch (e) {
        emit(UserError(message: e.toString()));
      }
    });
  }
}
