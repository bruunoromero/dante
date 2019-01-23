import 'package:dante/models/model.dart';
import 'package:reflectable/reflectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<T> _filteredDeclarationsOf<T extends DeclarationMirror>(
    ClassMirror cm, predicate) {
  var result = <T>[];
  cm.declarations.forEach((k, v) {
    if (predicate(v)) {
      result.add(v);
    }
  });
  return result;
}

List<MethodMirror> _gettersOf(ClassMirror cm) {
  return _filteredDeclarationsOf(cm, (v) => v is MethodMirror && v.isGetter);
}

List<VariableMirror> _variablesOf(ClassMirror cm) {
  return _filteredDeclarationsOf(cm, (v) => v is VariableMirror);
}

T _map<T extends BaseModel>(DocumentSnapshot document) {
  ClassMirror classMirror = model.reflectType(T);
  final namedArguments = document.data;

  classMirror.declarations.forEach((s, decl) {
    decl.metadata.where((m) => m is PrimaryKey).forEach((m) {
      namedArguments[decl.simpleName] = document.documentID;
    });
  });

  return classMirror.newInstance("fromJson", [namedArguments]) as T;
}

Map<String, dynamic> _unmap<T extends BaseModel>(T mapped) {
  final data = mapped.toJson();
  ClassMirror classMirror = model.reflectType(T);

  classMirror.declarations.forEach((s, decl) {
    decl.metadata.where((m) => m is PrimaryKey).forEach((m) {
      data.remove(decl.simpleName);
    });
  });

  return data;
}

class Query<T extends BaseModel> {
  final CollectionReference _collection;

  Query._(this._collection);

  T map(DocumentSnapshot document) {
    return _map(document);
  }

  Query<T> orderBy(String field, {bool descending = false}) {
    return Query<T>._(_collection.orderBy(field, descending: descending));
  }

  Query<T> startAfter(List<dynamic> values) {
    return Query<T>._(_collection.startAfter(values));
  }

  Query<T> startAt(List<dynamic> values) {
    return Query<T>._(_collection.startAt(values));
  }

  Query<T> endBefore(List<dynamic> values) {
    return Query<T>._(_collection.endBefore(values));
  }

  Query<T> endAt(List<dynamic> values) {
    return Query<T>._(_collection.endAt(values));
  }

  Query<T> limit(int limit) {
    return Query<T>._(_collection.limit(limit));
  }

  Stream<List<T>> snapshots() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.documents.map((document) => map(document)).toList();
    });
  }
}

class DocumentRepository<T extends BaseModel> {
  final DocumentReference _document;

  DocumentRepository._(this._document);

  BaseRepository<G> collection<G extends BaseModel>(String path) {
    return BaseRepository<G>._(_document.collection(path));
  }

  Future<T> get() async {
    final data = await _document.get();
    return _map(data);
  }

  Future<void> update(T model) {
    final data = _unmap(model);
    return _document.updateData(data);
  }

  Future<void> updateInTransaction(Function updater) {
    return Firestore.instance.runTransaction((tx) async {
      final snapshot = await tx.get(_document);
      final model = _map(snapshot) as T;
      final newModel = updater(model) as T;
      final data = _unmap(newModel);
      tx.update(snapshot.reference, data);
    });
  }
}

class BaseRepository<T extends BaseModel> extends Query<T> {
  BaseRepository(String collectionPath)
      : super._(Firestore.instance.collection(collectionPath));

  BaseRepository._(CollectionReference collection) : super._(collection);

  DocumentRepository<G> findByPk<G extends BaseModel>(String path) {
    final document = _collection.document(path);
    return DocumentRepository<G>._(document);
  }

  Future<void> update(String id, T model) {
    return DocumentRepository._(_collection.document("$id")).update(model);
  }

  Future<void> updateInTransaction(String id, Function updater) {
    final docRepo = DocumentRepository._(_collection.document("$id"));
    return docRepo.updateInTransaction(updater);
  }

  Future<DocumentRepository> create(T model) async {
    final document = await _collection.add(_unmap(model));
    return DocumentRepository._(document);
  }
}
