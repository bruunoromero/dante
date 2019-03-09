import 'package:flutter/material.dart';

class FormFieldContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget button;
  final bool hasValue;
  final TextEditingController controller;

  const FormFieldContainer(
      {this.title,
      this.child,
      this.button,
      this.hasValue = false,
      this.controller})
      : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 64),
                    child: Text(title),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 32),
                    child: child,
                  ),
                ],
              ),
            ),
            Container(
              child: AnimatedOpacity(
                opacity: hasValue ? 1.0 : 0.0,
                duration: Duration(milliseconds: 250),
                child: button,
              ),
            )
          ],
        ),
      ),
    );
  }
}
