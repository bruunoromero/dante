import 'package:dante/goals/api/goals_api.dart';
import 'package:flutter/material.dart';
import 'package:dante/goals/models/goal.dart';
import 'package:dante/goals/screens/home/goal_card.dart';

class HomeGoalsList extends StatelessWidget {
  HomeGoalsList({
    Key key,
  }) : super(key: key);

  _buildItem(documents) => (context, index) {
        Goal goal = documents[index];

        return HomeGoalCard(goal: goal);
      };

  Widget _buildList(BuildContext context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData)
      return SliverToBoxAdapter(
        child: const Text("loading..."),
      );

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        _buildItem(snapshot.data),
        childCount: snapshot.data.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GoalsApi.getGoals(),
      builder: _buildList,
    );
  }
}
