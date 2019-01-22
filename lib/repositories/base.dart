import 'package:dante/models/model.dart';
import 'package:reflectable/reflectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<X> _filteredDeclarationsOf<X extends DeclarationMirror>(
    ClassMirror cm, predicate) {
  var result = <X>[];
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

T _map<T>(DocumentSnapshot document) {
  ClassMirror classMirror = model.reflectType(T);
  final variables = _variablesOf(classMirror);
  Map<Symbol, dynamic> namedArguments = Map();

  variables.forEach((key) {
    namedArguments[Symbol(key.simpleName)] = document.data[key.simpleName];
  });

  classMirror.declarations.forEach((s, decl) {
    decl.metadata.where((m) => m is PrimaryKey).forEach((m) {
      namedArguments[Symbol(decl.simpleName)] = document.documentID;
    });
  });

  return classMirror.newInstance("", [], namedArguments) as T;
}

Map<String, dynamic> _unmap<T>(T mapped) {
  final map = new Map<String, dynamic>();
  ClassMirror classMirror = model.reflectType(T);
  InstanceMirror instanceMirror = model.reflect(mapped);
  final variables = _variablesOf(classMirror);

  variables.forEach((variable) {
    if (variable.simpleName != "id") {
      map[variable.simpleName] =
          instanceMirror.invokeGetter(variable.simpleName);
    }
  });

  return map;
}

class Query<T> {
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

class DocumentRepository<T> {
  final DocumentReference _document;

  DocumentRepository._(this._document);

  BaseRepository<G> collection<G>(String path) {
    return BaseRepository<G>._(_document.collection(path));
  }

  Future<T> get() async {
    final data = await _document.get();
    return _map(data);
  }

  Future<void> update(Function updater) {
    return Firestore.instance.runTransaction((tx) async {
      final snapshot = await tx.get(_document);
      final model = _map(snapshot) as T;
      final newModel = updater(model) as T;
      final data = _unmap(newModel);
      tx.update(snapshot.reference, data);
    });
  }
}

class BaseRepository<T> extends Query<T> {
  BaseRepository(String collectionPath)
      : super._(Firestore.instance.collection(collectionPath));

  BaseRepository._(CollectionReference collection) : super._(collection);

  DocumentRepository<G> findByPk<G>(String path) {
    final document = _collection.document(path);
    return DocumentRepository<G>._(document);
  }

  Future<void> update(String id, Function updater) {
    final docRepo = DocumentRepository._(_collection.document("$id"));
    return docRepo.update(updater);
  }

  Future<DocumentRepository> create(T model) async {
    final document = await _collection.add(_unmap(model));
    return DocumentRepository._(document);
  }
}
