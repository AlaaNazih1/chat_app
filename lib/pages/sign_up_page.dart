import 'package:chat_app/constant.dart';
import 'package:chat_app/pages/cahat_page.dart';
import 'package:chat_app/pages/cubits/rehister_cubit/register_cubit_cubit.dart';
import 'package:chat_app/widgets/custom_botton.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatelessWidget {
  String email = '';

  String password = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  static const String id = 'sign_up';

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubitCubit, RegisterCubitState>(
      listener: (context, state) {
         if (state is RegisterCubitLoading) {
          isLoading = true;
        } else if (state is RegisterCubitSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, CahatPage.id, arguments: email);
        } else if (state is RegisterCubitFailure) {
          isLoading = false;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.erroeMessage)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                          'Sign Up',
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
                    CustomBotton('Sign Up', () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<RegisterCubitCubit>(
                          context,
                        ).registerUser(email: email, password: password);

                      
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill all fields')),
                        );
                      }
                    }),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Alerady have an account? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign In',
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
        );
      },
    );
  }
}
