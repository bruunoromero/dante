import 'package:flutter/material.dart';
import 'package:dante/screens/create/field_container.dart';

class TitleField extends Field {
  TitleField({hasValue, onChange, button, focusNode})
      : super(
          button: button,
          hasValue: hasValue,
          onChange: onChange,
          focusNode: focusNode,
        );

  @override
  Widget build(BuildContext context) {
    return CreateFieldContainer(
      button: button,
      hasValue: hasValue,
      title: "Qual o seu objetivo?",
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
