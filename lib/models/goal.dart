import 'package:meta/meta.dart';
import 'package:dante/models/model.dart';

@model
class Goal extends BaseModel {
  String id;
  String date;
  String title;
  String aspect;
  String howToMesure;

  Goal({
    this.id,
    this.date = "",
    this.title = "",
    this.aspect = "",
    this.howToMesure = "",
  });
}
