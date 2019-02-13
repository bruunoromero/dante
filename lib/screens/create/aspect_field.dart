import 'package:flutter/material.dart';
import 'package:dante/screens/create/field_container.dart';

class AspectField extends Field {
  AspectField({hasValue, onChange, onTap, button, focusNode, controller})
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
        onTap: () {
          onTap(
            (context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        onChange("Work");
                      },
                      leading: Icon(Icons.work),
                      title: Text("Work"),
                    )
                  ],
                ),
              );
            },
          );
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
