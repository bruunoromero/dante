import 'package:flutter/material.dart';

class SliverDanteAppBar extends StatelessWidget {
  final Widget title;
  final Color backgroundColor;

  const SliverDanteAppBar({this.title, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title,
      pinned: true,
      backgroundColor: backgroundColor,
    );
  }
}

class DanteAppBar extends AppBar {
  DanteAppBar({
    Key key,
    leading,
    automaticallyImplyLeading = true,
    title,
    actions,
    flexibleSpace,
    bottom,
    elevation = 0.0,
    backgroundColor,
    brightness,
    iconTheme,
    textTheme,
    primary = true,
    centerTitle,
    titleSpacing = NavigationToolbar.kMiddleSpacing,
    toolbarOpacity = 1.0,
    bottomOpacity = 1.0,
  }) : super(
          key: key,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: title,
          actions: actions,
          flexibleSpace: flexibleSpace,
          bottom: bottom,
          elevation: elevation,
          backgroundColor: backgroundColor,
          brightness: brightness,
          iconTheme: iconTheme,
          textTheme: textTheme,
          primary: primary,
          centerTitle: centerTitle,
          titleSpacing: titleSpacing,
          toolbarOpacity: toolbarOpacity,
          bottomOpacity: bottomOpacity,
        );
}
