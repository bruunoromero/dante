import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dante/goals/models/goal.dart';

class GoalsApi {
  static Future<List<Goal>> getGoals() async {
    final snapshot =
        await Firestore.instance.collection("goals").getDocuments();

    return snapshot.documents.map((doc) => Goal.fromDocument(doc)).toList();
  }
}
