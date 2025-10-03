import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lottie/lottie.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/utils/app_routes.dart';
import 'package:movora/utils/auth_field.dart';
import 'package:movora/utils/auth_gradient_button.dart';
import 'package:movora/utils/snack_bar.dart';
import 'package:movora/viewmodels/firebase_auth_view_model.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController userNamecontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<FirebaseAuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Text(
                        'Sign in.',
                        style: TextStyle(
                          color: AppPallete.whiteColor,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Consumer<FirebaseAuthViewModel>(
                          builder: (context, authVM, child) {
                            return authVM.isTypingPassword
                                ? LottieBuilder.asset(
                                    'assets/Meditating Tiger.json',
                                    key: ValueKey(authVM.isTypingPassword),
                                  )
                                : LottieBuilder.asset(
                                    'assets/Cute Tiger (1).json',
                                    key: ValueKey(authVM.isTypingPassword),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  AuthField(
                    hintText: 'Username',
                    controller: userNamecontroler,
                  ),
                  SizedBox(height: 20),
                  AuthField(hintText: 'Email', controller: emailController),
                  SizedBox(height: 20),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordcontroller,
                    isPassword: true,
                  ),
                  SizedBox(height: 30),
                  AuthGradientButton(
                    buttonText: 'Sign in',
                    onpress: () async {
                      if (formKey.currentState!.validate()) {
                        await authVM.signUp(
                          emailController.text.trim(),
                          passwordcontroller.text.trim(),
                        );
                        if (authVM.user != null) {
                          Navigator.pushNamed(context, AppRoutes.login);
                          snackbar(
                            context,
                            "Login with the given Email and Password",
                          );
                        } else {
                          snackbar(
                            context,
                            Text(authVM.error ?? "Unknown erroe").toString(),
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppPallete.focusBorder,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
