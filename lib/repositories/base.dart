import 'package:dante/models/model.dart';
import 'package:reflectable/reflectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BaseRepository<T> {
  final String _collectionPath;
  CollectionReference _collection;

  BaseRepository(this._collectionPath) {
    _collection = Firestore.instance.collection(_collectionPath);
  }

  BaseRepository._(this._collection, this._collectionPath);

  CollectionReference get collection {
    return _collection;
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

  BaseRepository where(
    String field, {
    dynamic isEqualTo,
    dynamic isLessThan,
    dynamic isLessThanOrEqualTo,
    dynamic isGreaterThan,
    dynamic isGreaterThanOrEqualTo,
    dynamic arrayContains,
    bool isNull,
  }) {
    final coll = collection.where(
      field,
      isEqualTo: isEqualTo,
      isLessThan: isLessThan,
      isLessThanOrEqualTo: isLessThanOrEqualTo,
      isGreaterThan: isGreaterThan,
      isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
      arrayContains: arrayContains,
      isNull: isNull,
    );

    return BaseRepository._(coll, _collectionPath);
  }

  BaseRepository orderBy(String field, {bool descending = false}) {
    return BaseRepository._(
        collection.orderBy(field, descending: descending), _collectionPath);
  }

  BaseRepository startAfter(List<dynamic> values) {
    return BaseRepository._(collection.startAfter(values), _collectionPath);
  }

  BaseRepository startAt(List<dynamic> values) {
    return BaseRepository._(collection.startAt(values), _collectionPath);
  }

  BaseRepository endBefore(List<dynamic> values) {
    return BaseRepository._(collection.endBefore(values), _collectionPath);
  }

  BaseRepository endAt(List<dynamic> values) {
    return BaseRepository._(collection.endAt(values), _collectionPath);
  }

  BaseRepository limit(int limit) {
    return BaseRepository._(collection.limit(limit), _collectionPath);
  }

  Stream<List<T>> snapshots() {
    return collection.snapshots().map((snapshot) {
      return snapshot.documents.map((document) => from(document)).toList();
    });
  }
}
