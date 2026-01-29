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
        const _PositionedFloatingIcon(
          top: 50,
          left: 20,
          icon: Icons.local_pizza,
          angle: 0.2,
          duration: 3000,
        ),
        const _PositionedFloatingIcon(
          top: 100,
          right: -20,
          icon: Icons.lunch_dining,
          angle: -0.3,
          duration: 4000,
        ),
        const _PositionedFloatingIcon(
          top: 300,
          left: -10,
          icon: Icons.icecream,
          angle: 0.4,
          duration: 3500,
        ),
        const _PositionedFloatingIcon(
          top: 200,
          right: 50,
          icon: Icons.local_drink,
          angle: 0.1,
          duration: 4500,
        ),
        const _PositionedFloatingIcon(
          bottom: 150,
          left: 40,
          icon: Icons.ramen_dining,
          angle: -0.2,
          duration: 3200,
        ),
        const _PositionedFloatingIcon(
          bottom: 50,
          right: 10,
          icon: Icons.cake,
          angle: 0.3,
          duration: 3800,
        ),

        // More scattered icons
        const _PositionedFloatingIcon(
          top: 600,
          left: 200,
          icon: Icons.fastfood,
          angle: 0.5,
          duration: 4200,
        ),
        const _PositionedFloatingIcon(
          top: 150,
          left: 150,
          icon: Icons.bakery_dining,
          angle: -0.1,
          duration: 3100,
        ),
        const _PositionedFloatingIcon(
          bottom: 300,
          right: 100,
          icon: Icons.local_bar,
          angle: 0.2,
          duration: 3700,
        ),

        // Content
        child,
      ],
    );
  }
}

class _PositionedFloatingIcon extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final IconData icon;
  final double angle;
  final int duration;

  const _PositionedFloatingIcon({
    Key? key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.icon,
    required this.angle,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: _FloatingIcon(icon: icon, angle: angle, duration: duration),
    );
  }
}

class _FloatingIcon extends StatefulWidget {
  final IconData icon;
  final double angle;
  final int duration;

  const _FloatingIcon({
    Key? key,
    required this.icon,
    required this.angle,
    required this.duration,
  }) : super(key: key);

  @override
  State<_FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<_FloatingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Transform.rotate(
        angle: widget.angle,
        child: Icon(
          widget.icon,
          size: 80,
          color: AppColors.primary.withOpacity(0.08),
        ),
      ),
    );
  }
}
