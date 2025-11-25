import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/viewmodels/shift_booking_view_model.dart';
import 'package:provider/provider.dart';

class ShiftHubScreen extends StatelessWidget {
  const ShiftHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookVM = Provider.of<ShiftBookingViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Movora',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Choose Your Shift Type',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 70),

                // The two cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShiftCard(
                      icon: Icons.local_shipping_rounded,
                      title: 'Easy Shift',
                      description: 'For small or single-item deliveries',
                      glowColor: Color(0xFF3B82F6),
                      buttonColor: Color(0xFF3B82F6),
                      onTap: () {
                        bookVM.deliveryTypeController.text = 'Easy Shift';
                        Navigator.pushNamed(context, '/shiftbooking');
                      },
                    ),
                    ShiftCard(
                      icon: Icons.warehouse_rounded,
                      title: 'Bulk Shift',
                      description: 'For large or multi-item moves',
                      glowColor: Color(0xFFF97316),
                      buttonColor: Color(0xFFF97316),
                      onTap: () {
                        bookVM.deliveryTypeController.text = 'Bulk Shift';
                        Navigator.pushNamed(context, '/shiftbooking');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShiftCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color glowColor;
  final Color buttonColor;
  final VoidCallback onTap;

  const ShiftCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.glowColor,
    required this.buttonColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      width: 160,
      height: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 13, 13, 13), AppPallete.backgroundColor],
          stops: [
            0.5,
            0.0,
          ], // adjust this to control where the “cut” line appears
        ),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          // soft ambient glow
          BoxShadow(
            color: glowColor.withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: -5,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // glowing icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: glowColor.withOpacity(0.0),
              boxShadow: [
                BoxShadow(
                  color: glowColor.withOpacity(0.6),
                  blurRadius: 25,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Icon(icon, color: glowColor, size: 36),
          ),

          // title
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              children: [
                TextSpan(text: title.split(' ')[0] + ' '),
                TextSpan(
                  text: title.split(' ')[1],
                  style: TextStyle(
                    color: glowColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // description
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              height: 1.4,
              letterSpacing: 0.2,
            ),
          ),

          // select button
          ElevatedButton(
            onPressed: onTap,

            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              shadowColor: buttonColor.withOpacity(0.6),
            ),
            child: Text(
              'Select',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
