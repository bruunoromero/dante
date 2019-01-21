import 'package:flutter/material.dart';
import 'package:dante/models/goal.dart';
import 'package:dante/screens/home/goal_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeGoalsList extends StatelessWidget {
  final _goalsCollection = Firestore.instance.collection("okrs");

  HomeGoalsList({
    Key key,
  }) : super(key: key);

  _buildItem(documents) => (context, index) {
        final document = documents[index];
        final goal = Goal.of(document);

        return HomeGoalCard.of(goal);
      };

  Widget _buildList(BuildContext context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData)
      return SliverToBoxAdapter(
        child: const Text("loading..."),
      );

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        _buildItem(snapshot.data.documents),
        childCount: snapshot.data.documents.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _goalsCollection.snapshots(),
      builder: _buildList,
    );
  }
}
