import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/viewmodels/firebase_auth_view_model.dart';
import 'package:movora/viewmodels/shift_booking_view_model.dart';
import 'package:provider/provider.dart';

class SliderMenu extends StatefulWidget {
  const SliderMenu({super.key});

  @override
  State<SliderMenu> createState() => _SliderMenuState();
}

class _SliderMenuState extends State<SliderMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<FirebaseAuthViewModel>(context);
    return Container(
      width: 288,
      height: double.infinity,
      color: const Color.fromARGB(255, 33, 32, 32),
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppPallete.transparent,
                child: Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              title: Text(authVM.currentUserModel?.username ?? "Guest"),
              subtitle: Text(authVM.currentUserModel?.email ?? "Not logged in"),

              trailing: IconButton(
                onPressed: () {
                  authVM.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
