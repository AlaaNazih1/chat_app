import 'package:bloc/bloc.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await AuthService.signIn(email: email, password: password);
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


  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterCubitLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterCubitSuccess());
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'An account already exists for that email.';
          break;
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = e.message ?? 'Registration failed. Please try again.';
      }
      emit(RegisterCubitFailure(erroeMessage: message));
    } catch (e) {
      emit(
        RegisterCubitFailure(
          erroeMessage: 'Registration failed. Please try again.',
        ),
      );
    }
  }
}
