import 'package:flutter/material.dart';

class FormFieldContainer extends StatelessWidget {
  final Widget child;

  const FormFieldContainer({this.child}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: child,
    );
  }
}
