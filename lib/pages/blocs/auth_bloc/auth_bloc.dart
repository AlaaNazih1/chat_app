import 'package:bloc/bloc.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async
    {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          await AuthService.signIn(email: event.email, password: event.password);
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
        
      } else if (event is RegisterEvent) {
        emit(RegisterCubitLoading());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
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
            default:
              message = e.message ?? 'Registration failed. Please try again.';
          }
          emit(RegisterCubitFailure(erroeMessage: message));
        }
      }
    });
  }
}
