import 'package:flutter/material.dart';

class DanteGradient extends LinearGradient {
  DanteGradient(List<Color> colors)
      : super(
          end: Alignment.centerRight,
          begin: Alignment.centerLeft,
          colors: colors,
        );

  get color {
    return Colors.transparent;
  }
}

class BlueSkies extends DanteGradient {
  static final _colors = [
    Color(0xFF56CCF2),
    Color(0xFF2F80ED),
  ];

  BlueSkies() : super(_colors);

  @override
  get color {
    return _colors[0];
  }
}
