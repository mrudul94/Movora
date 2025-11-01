import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/utils/app_routes.dart';
import 'package:movora/utils/auth_field.dart';
import 'package:movora/utils/auth_gradient_button.dart';
import 'package:movora/utils/snack_bar.dart';
import 'package:movora/utils/tiger_animation.dart';
import 'package:movora/viewmodels/firebase_auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<FirebaseAuthViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
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
                      // Spacer(flex: 10),
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Tiger_animation(),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  AuthField(
                    hintText: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordcontroller,
                    isPassword: true,
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: AlignmentGeometry.topRight,
                    child: TextButton(
                      onPressed: () async {
                        await authVM.resetPassword(emailController.text.trim());
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: AppPallete.focusBorder),
                      ),
                    ),
                  ),
                  AuthGradientButton(
                    buttonText: 'Sign in',
                    onpress: () async {
                      if (formKey.currentState!.validate()) {
                        await authVM.login(
                          emailController.text.trim(),
                          passwordcontroller.text.trim(),
                        );
                        if (authVM.user != null) {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.home,
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
                      Navigator.pushReplacementNamed(context, AppRoutes.signup);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
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
                    text: "Sign in with Google",
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
