import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gf;

class AnimatedWobblyTitle extends StatefulWidget {
  @override
  _AnimatedWobblyTitleState createState() => _AnimatedWobblyTitleState();
}

class _AnimatedWobblyTitleState extends State<AnimatedWobblyTitle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Duration of the wobble effect
      vsync: this,
    )..repeat(reverse: true); // Repeat the animation back and forth

    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value), // Apply the wobble effect
          child: Text(
            'What Will You Do?',
            style: gf.GoogleFonts.poppins(color: Colors.white, fontSize: 20),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
