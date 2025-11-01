import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/viewmodels/firebase_auth_view_model.dart';
import 'package:provider/provider.dart';

class SliderMenu extends StatelessWidget {
  const SliderMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<FirebaseAuthViewModel>(context);
    return Container(
      width: 288,
      height: double.infinity,
      color: AppPallete.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Mrudul'),
              subtitle: Text('kerala'),
              trailing: IconButton(
                onPressed: () {
                  authVM.logout();
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
