import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const GradientIcon({super.key, required this.icon, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) =>
              isActive
                  ? const LinearGradient(
                    colors: [
                      Color(0xFF0F2027),
                      Color(0xFF203A43),
                      Color(0xFF2C5364),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds)
                  : const LinearGradient(
                    colors: [Colors.grey, Colors.grey],
                  ).createShader(bounds),
      child: Icon(icon, color: Colors.white),
    );
  }
}
