import 'package:flutter/material.dart';
import 'package:dante/goals/models/goal.dart';
import 'package:dante/goals/screens/edit.dart';
import 'package:dante/goals/screens/create.dart';

MaterialPageRoute createScreenRoute() {
  return MaterialPageRoute(
      builder: (context) => CreateScreen(), fullscreenDialog: true);
}

MaterialPageRoute editScreenRoute({@required Goal goal}) {
  return MaterialPageRoute(
      builder: (context) => EditScreen(goal: goal), fullscreenDialog: true);
}
