import 'package:reflectable/reflectable.dart';

class Reflector extends Reflectable {
  const Reflector()
      : super(
          invokingCapability,
          metadataCapability,
          newInstanceCapability,
          declarationsCapability,
          instanceInvokeCapability,
        );
}

const model = Reflector();

class PrimaryKey {
  const PrimaryKey();
}
