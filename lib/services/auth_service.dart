
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static const String usersCollection = 'users';

static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signUp({
    required String email,
    required String password,
   
  }) async {
     {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
     
    
    }

   Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  
}
}