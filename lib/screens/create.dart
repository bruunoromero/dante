import 'package:flutter/material.dart';
import 'package:dante/widgets/app_bar.dart';
import 'package:dante/widgets/scaffold.dart';
import 'package:dante/screens/form/form.dart';

class CreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DanteScaffold(
      appBar: DanteAppBar(
        title: Text("Create OKR"),
      ),
      body: [
        SliverToBoxAdapter(
          child: GoalForm(),
        ),
      ],
    );
  }
}