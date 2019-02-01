import 'package:dante/screens/create/field_container.dart';
import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final bool hasValue;
  final Function onNext;
  final FocusNode focusNode;
  final Function onChange;

  TitleField({this.hasValue, this.onChange, this.onNext, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return CreateFieldContainer(
      hasValue: hasValue,
      button: RaisedButton(onPressed: onNext),
      title: "Qual a sua meta?",
      child: TextField(
        onChanged: onChange,
        focusNode: focusNode,
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}
