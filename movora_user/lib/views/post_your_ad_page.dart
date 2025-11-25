import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/viewmodels/shift_booking_view_model.dart';
import 'package:movora/views/create_post.dart';
import 'package:provider/provider.dart';

class PostYourAdPage extends StatefulWidget {
  const PostYourAdPage({super.key});

  @override
  State<PostYourAdPage> createState() => _PostYourAdPageState();
}

class _PostYourAdPageState extends State<PostYourAdPage> {
  @override
  void initState() {
    super.initState();
    // Automatically fetch bookings when page opens
    final bookVM = Provider.of<ShiftBookingViewModel>(context, listen: false);
    bookVM.fetchShiftBookingdetails(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppPallete.transparent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePost()),
          );
        },
        child: Icon(
          Icons.add_circle_outline_outlined,
          color: AppPallete.focusBorder,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
