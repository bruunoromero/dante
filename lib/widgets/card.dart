import 'package:dante/theme/gradient.dart';
import 'package:flutter/material.dart';

class DanteCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final EdgeInsets margin;
  final double borderRadius;
  final LinearGradient gradient;
  final GestureTapCallback onTap;

  const DanteCard({
    this.child,
    this.onTap,
    this.margin,
    this.gradient,
    this.elevation = 4,
    this.borderRadius = 6,
  });

  Widget buildContainer() {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: buildChild(),
    );
  }

  Widget buildChild() {
    return onTap != null ? buildInk() : child;
  }

  Widget buildInk() {
    return InkWell(onTap: onTap, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: buildContainer(),
    );
  }
}
