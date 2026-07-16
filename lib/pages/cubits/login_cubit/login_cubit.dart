import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:chat_app/services/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await AuthService.signIn(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
  String message;
  switch (e.code) {
    case 'user-not-found':
      message = 'No user found for that email.';
      break;
    case 'wrong-password':
      message = 'Wrong password provided for that user.';
      break;
    case 'invalid-credential':
      message = 'Incorrect email or password.';
      break;
    default:
      message = e.message ?? 'Login failed. Please try again.';
  }
  emit(LoginFailure(erroeMessage: message));
}
  }
}
