part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

 class LoginInitial extends LoginState {}
 class LoginLoading extends LoginState {}
 class LoginSuccess extends LoginState {}
 class LoginFailure extends LoginState {
  String erroeMessage;
   LoginFailure({required this.erroeMessage});
 }
