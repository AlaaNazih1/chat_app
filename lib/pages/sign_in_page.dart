import 'package:chat_app/constant.dart';
import 'package:chat_app/pages/cahat_page.dart';
import 'package:chat_app/pages/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/pages/sign_up_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/custom_botton.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInScreen extends StatelessWidget {
  String email = '';

  String password = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          Navigator.pushNamed(
            context,
            CahatPage.id,
            arguments: email,
          );
        } else if (state is LoginFailure) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed. Please try again.'),
            ),
          );
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(height: 75),
                  Image.asset('assets/images/scholar.png', height: 100),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 75),
                  Row(
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: 'Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    isPassword: true,
                    hintText: 'Password',
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomBotton('Sign In', () {
                    if (formKey.currentState!.validate()) {
                      AuthService.signIn(
                        email: email,
                        password: password,
                        context: context,
                      );

                      Navigator.pushNamed(
                        context,
                        CahatPage.id,
                        arguments: email,
                      );
                    }
                  }),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpPage.id);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 75),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
