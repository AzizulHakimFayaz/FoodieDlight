import 'package:flutter/material.dart';
import 'dart:math';
import '../constants/app_colors.dart';

class BackgroundPattern extends StatelessWidget {
  final Widget child;

  const BackgroundPattern({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Color
        Container(color: AppColors.background),

        // Floating Icons Pattern
        const Positioned(
          top: 50,
          left: 20,
          child: _FloatingIcon(Icons.local_pizza, angle: 0.2),
        ),
        const Positioned(
          top: 100,
          right: -20,
          child: _FloatingIcon(Icons.lunch_dining, angle: -0.3),
        ),
        const Positioned(
          top: 300,
          left: -10,
          child: _FloatingIcon(Icons.icecream, angle: 0.4),
        ),
        const Positioned(
          top: 200,
          right: 50,
          child: _FloatingIcon(Icons.local_drink, angle: 0.1),
        ),
        const Positioned(
          bottom: 150,
          left: 40,
          child: _FloatingIcon(Icons.ramen_dining, angle: -0.2),
        ),
        const Positioned(
          bottom: 50,
          right: 10,
          child: _FloatingIcon(Icons.cake, angle: 0.3),
        ),

        // More scattered icons
        const Positioned(
          top: 600,
          left: 200,
          child: _FloatingIcon(Icons.fastfood, angle: 0.5),
        ),
        const Positioned(
          top: 150,
          left: 150,
          child: _FloatingIcon(Icons.bakery_dining, angle: -0.1),
        ),
        const Positioned(
          bottom: 300,
          right: 100,
          child: _FloatingIcon(Icons.local_bar, angle: 0.2),
        ),

        // Content
        child,
      ],
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  final IconData icon;
  final double angle;

  const _FloatingIcon(this.icon, {required this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Icon(
        icon,
        size: 80, // Large faint icons
        color: AppColors.primary.withOpacity(0.08), // Very low opacity
      ),
    );
  }
}
