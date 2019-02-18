import 'package:flutter/material.dart';
import 'package:dante/screens/create/field_container.dart';

class AspectField extends Field {
  AspectField({hasValue, onChange, button, controller})
      : super(
          button: button,
          hasValue: hasValue,
          onChange: onChange,
          controller: controller,
        );

  Widget _buildOption(BuildContext context, IconData icon, String text) {
    final isSelected = controller.text == text;
    final color = isSelected ? Colors.white : Colors.black;

    final child = Padding(
      padding: EdgeInsets.all(6),
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            text,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
    final onPressed = () {
      onChange(text);
    };

    if (isSelected) {
      return RaisedButton(
        child: child,
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
      );
    }

    return OutlineButton(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CreateFieldContainer(
      title: "hey",
      button: button,
      hasValue: hasValue,
      child: Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: <Widget>[
            _buildOption(context, Icons.work, "Work"),
            _buildOption(context, Icons.arrow_drop_down, "asd"),
            _buildOption(context, Icons.arrow_drop_down_circle, "Wsdork"),
            _buildOption(context, Icons.arrow_forward, "ss"),
          ],
        ),
      ),
    );
  }
}
