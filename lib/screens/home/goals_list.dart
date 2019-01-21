import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dante/models/goal.dart';
import 'package:dante/repositories/goal.dart';
import 'package:dante/screens/home/goal_card.dart';

class HomeGoalsList extends StatelessWidget {
  final _goalsRepository = GoalRepository();

  HomeGoalsList({
    Key key,
  }) : super(key: key);

  _buildItem(documents) => (context, index) {
        Goal goal = documents[index];

        return HomeGoalCard.of(goal);
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
    return StreamBuilder(
      stream: _goalsRepository.all(),
      builder: _buildList,
    );
  }
}
