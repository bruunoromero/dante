import 'package:dante/models/model.dart';
import 'package:reflectable/reflectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BaseRepository<T> {
  final String collectionPath;
  CollectionReference _collection;

  BaseRepository(this.collectionPath) {
    _collection = Firestore.instance.collection(collectionPath);
  }

  Stream<QuerySnapshot> snapshots() {
    return _collection.snapshots();
  }

  T from(DocumentSnapshot document) {    
    ClassMirror classMirror = model.reflectType(T);
    Map<Symbol, dynamic> namedArguments = Map();

    document.data.keys.forEach((key) {
      namedArguments[Symbol(key)] = document.data[key];
    });

    namedArguments[#id] = document.documentID;

    return classMirror.newInstance("", [], namedArguments) as T;
  }

  Stream<List<T>> all() {
    return snapshots().map((snapshot) {
      return snapshot.documents.map((document) => from(document)).toList();
    });
  }
}
