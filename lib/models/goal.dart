import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Goal {
  final String id;
  final String date;
  final String title;
  final String aspect;
  final String howToMesure;

  const Goal({
    this.id,
    @required this.date,
    @required this.title,
    @required this.aspect,
    @required this.howToMesure,
  });

  static Goal of(DocumentSnapshot document) {
    return Goal(
      id: document.documentID,
      date: document['date'],
      title: document['title'],
      aspect: document['aspect'],
      howToMesure: document['howToMesure'],
    );
  }
}
