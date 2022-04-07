import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';

class ContainerShadow extends StatelessWidget {
  final Widget child;
  final double radius;
  final bool reverse, useShadow;
  final EdgeInsetsGeometry margin, padding;
  final Color color;

  const ContainerShadow({
    this.child = const SizedBox(),
    this.radius = 4.0,
    this.reverse = false,
    this.useShadow = true,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      padding: padding,
      margin: margin,
      child: child,
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          if (useShadow)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: reverse ? Offset(4, 0) : Offset(0, 4),
            )
          // BoxShadow(
          //   color: Colors.black12,
          //   blurRadius: 4,
          //   offset: Offset(0, 2),
          // ),
        ],
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
