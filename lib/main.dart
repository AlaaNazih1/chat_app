import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/cahat_page.dart';
import 'package:chat_app/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/pages/cubits/rehister_cubit/register_cubit_cubit.dart';
import 'package:chat_app/pages/sign_in_page.dart';
import 'package:chat_app/pages/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create:  (context) => RegisterCubitCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          'sign_in': (context) => SignInScreen(),
          SignUpPage.id: (context) => SignUpPage(),

          CahatPage.id: (context) => CahatPage(),
        },
        debugShowCheckedModeBanner: false,
        home: SignInScreen(),
      ),
    );
  }
}
