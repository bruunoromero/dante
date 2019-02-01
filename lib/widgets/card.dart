import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

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

  Widget _buildChild() {
    return InkWell(
      onTap: onTap,
      child: child,
    );
  }

  Widget _buildContainer() {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: _buildChild(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: _buildContainer(),
    );
  }
}
