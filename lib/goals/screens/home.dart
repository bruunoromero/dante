import 'package:dante/routes.dart';
import 'package:dante/utils/tab.dart';
import 'package:flutter/material.dart';
import 'package:dante/widgets/app_bar.dart';
import 'package:dante/widgets/scaffold.dart';
import 'package:dante/goals/screens/home/goals_list.dart';

class HomeScreen extends ITab {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  FloatingActionButton actionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, createScreenRoute());
      },
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverDanteScaffold(
      appBar: SliverDanteAppBar(
        title: Text("Home"),
      ),
      body: [HomeGoalsList()],
    );
  }
}
