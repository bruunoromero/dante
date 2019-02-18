import 'package:dante/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goal.g.dart';

@Model()
@JsonSerializable()
class Goal extends BaseModel {
  @PrimaryKey()
  String id;
  String title;
  String aspect;
  String date;
  String howToMesure;

  Goal({
    this.id,
    this.date = "",
    this.title = "",
    this.aspect = "",
    this.howToMesure = "",
  });

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
