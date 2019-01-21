import 'package:dante/models/goal.dart';
import 'package:dante/repositories/base.dart';

class GoalRepository extends BaseRepository<Goal> {
  GoalRepository() : super("okrs");
}