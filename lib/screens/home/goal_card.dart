import 'package:dante/routes.dart';
import 'package:flutter/material.dart';
import 'package:dante/models/goal.dart';
import 'package:dante/widgets/card.dart';
import 'package:dante/screens/edit.dart';

class HomeGoalCard extends StatelessWidget {
  final Goal goal;

  const HomeGoalCard({@required this.goal}) : super();

  Widget buildCard() {
    return ListTile(
      leading: buildLeading(),
      title: buildTitle(),
      subtitle: buildSubtitle(),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        size: 30.0,
        color: Colors.red,
      ),
    );
  }

  Container buildLeading() {
    return Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
        border: new Border(
          right: new BorderSide(
            width: 1.0,
            color: Colors.red,
          ),
        ),
      ),
      child: Icon(
        Icons.autorenew,
        color: Colors.red,
      ),
    );
  }

  Row buildSubtitle() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.linear_scale,
          color: Colors.yellowAccent,
        ),
        Text(
          " Intermediate",
          style: TextStyle(color: Colors.red),
        )
      ],
    );
  }

  Text buildTitle() => Text(goal.title);

  @override
  Widget build(BuildContext context) {
    return DanteCard(
      onTap: () {
        Navigator.push(context, editScreenRoute(goal: goal));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: buildCard(),
      ),
    );
  }
}
