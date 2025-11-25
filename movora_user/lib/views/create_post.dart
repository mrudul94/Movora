import 'package:flutter/material.dart';
import 'package:movora/services/placeholder.dart';
import 'package:movora/utils/app_pattete.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.transparent,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPallete.focusBorder,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),

            onPressed: () {},
            child: Text('Post', style: TextStyle(color: AppPallete.textColor)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppPallete.focusBorder),
                    ),
                    child: productImages.isEmpty
                        ? Center(child: Text('+ Add'))
                        : Row(
                            spacing: 2,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 120,
                                width: 100,
                                color: Colors.amber,
                              ),
                              Container(
                                height: 120,
                                width: 100,
                                color: Colors.amber,
                              ),
                              Container(
                                height: 120,
                                width: 100,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
