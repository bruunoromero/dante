import 'package:cloud_firestore/cloud_firestore.dart';

class Goal {
  String id;
  String title;
  String aspect;
  DateTime dueDate;
  DateTime createdAt;
  String howToMesure;
  int numberOfActions;
  int numberOfDoneActions;

  Goal({
    this.id,
    this.title,
    this.aspect,
    this.dueDate,
    this.howToMesure,
    this.numberOfActions = 0,
    this.numberOfDoneActions = 0,
    DateTime createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Goal.fromDocument(DocumentSnapshot document) => Goal(
        id: document.documentID,
        title: document.data["title"],
        aspect: document.data["aspect"],
        dueDate: document.data["dueDate"],
        createdAt: document.data["createdAt"],
        numberOfActions: document.data["numberOfActions"],
        numberOfDoneActions: document.data["numberOfDoneActionss"],
      );

  Map<String, dynamic> toCreateDocument() => {
        "title": title,
        "aspect": aspect,
        "dueDate": dueDate,
        "numberOfActions": 0,
        "createdAt": createdAt,
        "numberOfDoneActions": 0,
        "howToMesure": howToMesure,
      };
}
