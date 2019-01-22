import 'package:reflectable/reflectable.dart';

class Reflector extends Reflectable {
  const Reflector()
      : super(
          invokingCapability,
          newInstanceCapability,
          declarationsCapability,
          instanceInvokeCapability,
        );
}

const model = Reflector();

class BaseModel {
  String id;
}
