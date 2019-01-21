import 'package:flutter/material.dart';

class DanteAppBar extends StatelessWidget {
  final Widget title;
  final Color backgroundColor;

  const DanteAppBar({this.title, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title,
      pinned: true,
      backgroundColor: backgroundColor,
    );
  }
}
