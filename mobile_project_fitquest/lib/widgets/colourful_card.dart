import 'package:flutter/material.dart';

class ColourfulCard extends StatelessWidget {
  final Color color;
  final Widget child;
  final double height;
  final double borderRadius;

  const ColourfulCard({
    super.key,
    required this.color,
    required this.child,
    this.height = 140,
    this.borderRadius = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
