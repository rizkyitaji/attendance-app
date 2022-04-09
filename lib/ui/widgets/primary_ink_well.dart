import 'package:flutter/material.dart';

class PrimaryInkWell extends StatelessWidget {
  final double radius;
  final VoidCallback? onTap, onLongPress;
  final Widget? child;

  PrimaryInkWell({
    this.radius = 5,
    this.onTap,
    this.onLongPress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: child,
          onLongPress: onLongPress,
        ),
      ),
    );
  }
}
