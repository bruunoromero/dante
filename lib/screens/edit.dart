import 'package:dante/models/goal.dart';
import 'package:flutter/material.dart';
import 'package:dante/widgets/app_bar.dart';
import 'package:dante/widgets/scaffold.dart';
import 'package:dante/screens/form/form.dart';

class EditScreen extends StatelessWidget {
  final Goal goal;

  const EditScreen({@required this.goal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create OKR"),
      ),
      body: GoalForm(
        goal: goal,
      ),
    );
  }
}
