import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserEntity> users;

  UserLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});

  @override
  List<Object?> get props => [message];
}
