import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:confetti/confetti.dart';
import 'package:movora/views/shift_updates.dart';

class ShiftBookedPage extends StatefulWidget {
  const ShiftBookedPage({super.key});

  @override
  State<ShiftBookedPage> createState() => _ShiftBookedPageState();
}

class _ShiftBookedPageState extends State<ShiftBookedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _confettiController.play(); // 🎉 Start confetti

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        // Navigator.pushReplacement(
        //   context,
        //   // createAnimatedRoute( ShiftUpdates(: )),
        // );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          /// 🔥 GREEN ANIMATION ONLY ON BACKGROUND
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.0, _controller.value],
                    colors: [Colors.green, Colors.transparent],
                  ).createShader(rect);
                },
                blendMode: BlendMode.srcATop,
                child: Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),

          /// 🎉 CONFETTI BEHIND THE LOTTIE
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.03,
            numberOfParticles: 6,
            shouldLoop: false,
            maxBlastForce: 7,
            minBlastForce: 2,
            gravity: 0.3,
          ),

          /// 🎉 LOTTIE + TEXT (not affected by shader or confetti)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/json/shiftbooked.json",
                width: 600,
                repeat: false,
              ),
              const SizedBox(height: 12),
              Text(
                "Shift Booked!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Route createAnimatedRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Fade animation
      final fade = Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

      // Scale animation (zoom in)
      final scale = Tween(
        begin: 0.9,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutBack));

      return FadeTransition(
        opacity: fade,
        child: ScaleTransition(scale: scale, child: child),
      );
    },
  );
}
