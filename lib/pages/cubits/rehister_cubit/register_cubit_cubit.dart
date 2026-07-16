import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_cubit_state.dart';

class RegisterCubitCubit extends Cubit<RegisterCubitState> {
  RegisterCubitCubit() : super(RegisterCubitInitial());

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
