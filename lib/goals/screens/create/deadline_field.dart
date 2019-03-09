import 'package:flutter/material.dart';
import 'package:dante/goals/screens/create/field_container.dart';

class DeadlineField extends Field {
  DeadlineField({hasValue, onChange, onTap, button, focusNode, controller})
      : super(
          onTap: onTap,
          button: button,
          hasValue: hasValue,
          onChange: onChange,
          controller: controller,
        );

  @override
  Widget build(BuildContext context) {
    return CreateFieldContainer(
      title: "hey",
      button: button,
      hasValue: hasValue,
      child: InkWell(
        onTap: () async {
          final date = await onTap(context);

          if (date != null) {
            onChange(date);
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
