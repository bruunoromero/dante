import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class DanteCard extends StatefulWidget {
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

  @override
  DanteCardState createState() {
    return new DanteCardState();
  }
}

class DanteCardState extends State<DanteCard> {
  double _scale = 1.0;

  Widget _buildChild() {
    return GestureDetector(
      onTap: widget.onTap,
      onTapCancel: () {
        setState(() {
          _scale = 1.0;
        });
      },
      onTapDown: (tap) {
        setState(() {
          _scale = 0.75;
        });
      },
    );
  }

  Widget buildContainer() {
    return AnimatedContainer(
      duration: Duration(),
      transform: Matrix4.translation(Vector3.all(_scale)),
      child: Container(
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: _buildChild(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: widget.margin,
      elevation: widget.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: buildContainer(),
    );
  }
}
