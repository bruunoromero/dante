import 'package:dante/goals/screens/create/field_container.dart';
import 'package:flutter/material.dart';

class HowToMesureField extends Field {
  HowToMesureField({hasValue, onChange, button, focusNode})
      : super(
          button: button,
          hasValue: hasValue,
          onChange: onChange,
          focusNode: focusNode,
        );

  @override
  Widget build(BuildContext context) {
    return CreateFieldContainer(
      title: "hey",
      button: button,
      hasValue: hasValue,
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
