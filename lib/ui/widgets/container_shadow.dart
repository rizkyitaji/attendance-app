import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';

class ContainerShadow extends StatelessWidget {
  final Widget child;
  final double radius;
  final bool reverse, useShadow;
  final EdgeInsetsGeometry margin, padding;
  final Color color;
  final VoidCallback? onTap;

  const ContainerShadow({
    this.child = const SizedBox(),
    this.radius = 5,
    this.reverse = false,
    this.useShadow = true,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.color = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width(context),
        padding: padding,
        margin: margin,
        child: child,
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            if (useShadow)
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
          ],
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
