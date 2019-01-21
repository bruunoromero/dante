import 'package:reflectable/reflectable.dart';

class Reflector extends Reflectable {
  const Reflector()
      : super(instanceInvokeCapability, newInstanceCapability,
            declarationsCapability);
}

const model = Reflector();