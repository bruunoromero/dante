import 'package:reflectable/reflectable.dart';

class Model extends Reflectable {
  const Model()
      : super(
          invokingCapability,
          metadataCapability,
          newInstanceCapability,
          declarationsCapability,
          instanceInvokeCapability,
        );
}

class PrimaryKey {
  const PrimaryKey();
}

const model = Model();

abstract class BaseModel {
  Map<String, dynamic> toJson();
}
