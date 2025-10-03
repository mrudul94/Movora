import 'package:flutter/material.dart';
import 'package:movora/viewmodels/firebase_auth_view_model.dart';
import 'package:provider/provider.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<FirebaseAuthViewModel>(context, listen: false);
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? authVM.obscurePassword : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
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
          return "${widget.hintText} is missing!";
        }
        return null;
      },
      onChanged: widget.isPassword
          ? (value) {
              authVM.setTypingPassword(value.isNotEmpty);
            }
          : null,
    );
  }
}
