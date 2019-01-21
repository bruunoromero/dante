import 'package:meta/meta.dart';
import 'package:dante/models/model.dart';

@model
class Goal {
  String id;
  String date;
  String title;
  String aspect;
  String howToMesure;

  Goal({
    this.id,
    @required this.date,
    @required this.title,
    @required this.aspect,
    @required this.howToMesure,
  });
}
