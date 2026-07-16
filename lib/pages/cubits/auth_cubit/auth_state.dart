part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

 class AuthInitial extends AuthState {}
  class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  String erroeMessage;
  LoginFailure({required this.erroeMessage});
}


class RegisterCubitInitial extends AuthState {}

class RegisterCubitLoading extends AuthState {}

class RegisterCubitSuccess extends AuthState {}

class RegisterCubitFailure extends AuthState {
  String erroeMessage;
  RegisterCubitFailure({required this.erroeMessage});
}

