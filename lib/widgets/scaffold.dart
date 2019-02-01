import 'package:flutter/material.dart';

class SliverDanteScaffold extends StatelessWidget {
  final Widget appBar;
  final List<Widget> body;
  final Widget floatingActionButton;

  const SliverDanteScaffold({this.appBar, this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    final slivers = [appBar].followedBy(body).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: slivers,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
