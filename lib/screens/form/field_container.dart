import 'package:flutter/material.dart';

class FormFieldContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget button;

  const FormFieldContainer({this.title, this.child, this.button}) : super();

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
              child: button,
            )
          ],
        ),
      ),
    );
  }
}
