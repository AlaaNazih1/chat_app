import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:meta/meta.dart';

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
        context: context,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure());
    }
  }
}
