import 'package:dante/routes.dart';
import 'package:dante/utils.dart';
import 'package:flutter/material.dart';
import 'package:dante/goals/models/goal.dart';
import 'package:dante/widgets/card.dart';

class HomeGoalCard extends StatelessWidget {
  final Goal goal;

  const HomeGoalCard({@required this.goal}) : super();

  Widget buildCard(context) {
    return ListTile(
      leading: buildLeading(context),
      title: buildTitle(),
      subtitle: buildSubtitle(context),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        size: 30.0,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Container buildLeading(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
        border: new Border(
          right: new BorderSide(
            width: 1.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      child: Icon(
        textToIcon(goal.aspect),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Row buildSubtitle(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.linear_scale,
          color: Colors.yellowAccent,
        ),
        Text(
          " Intermediate",
          style: TextStyle(color: Theme.of(context).primaryColor),
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
        child: buildCard(context),
      ),
    );
  }
}
