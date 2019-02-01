import 'package:dante/screens/create/field_container.dart';
import 'package:flutter/material.dart';

class HowToMesureField extends StatelessWidget {
  final bool hasValue;
  final Function onNext;
  final FocusNode focusNode;
  final Function onChange;

  HowToMesureField({this.hasValue, this.onChange, this.onNext, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return CreateFieldContainer(
      hasValue: true,
      button: RaisedButton(onPressed: onNext),
      title: "hey",
      child: TextField(
        onChanged: onChange,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: "Como saber se a meta foi antigida?",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
