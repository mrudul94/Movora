import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/viewmodels/firebase_auth_view_model.dart';
import 'package:provider/provider.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<FirebaseAuthViewModel>(context);
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? authVM.obscurePassword : false,
      cursorColor: AppPallete.focusBorder,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  authVM.toggleObscure();
                },
                icon: Icon(
                  authVM.obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              )
            : null,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),

      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      onChanged: isPassword
          ? (value) {
              authVM.setTypingPassword(value.isNotEmpty);
            }
          : null,
    );
  }
}
