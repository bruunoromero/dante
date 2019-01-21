import 'package:dante/screens/home/goals_list.dart';
import 'package:flutter/material.dart';
import 'package:dante/widgets/app_bar.dart';
import 'package:dante/widgets/scaffold.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return DanteScaffold(
      appBar: DanteAppBar(
        title: Text("Home"),
      ),
      body: [HomeGoalsList()],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/modals/create");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
