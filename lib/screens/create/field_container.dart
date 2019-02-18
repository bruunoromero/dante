import 'package:flutter/material.dart';

class CreateFieldContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget button;
  final bool hasValue;

  const CreateFieldContainer({
    this.child,
    this.title,
    this.button,
    this.hasValue,
  });

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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 96, 0, 24),
                          child: Text(title),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: child,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: hasValue ? 1.0 : 0.0,
                child: button,
              ),
            )
          ],
        ),
      ),
    );
  }
}

abstract class Field extends StatelessWidget {
  final bool hasValue;
  final Widget button;
  final Function onTap;
  final Function onChange;
  final FocusNode focusNode;
  final TextEditingController controller;

  Field({
    this.onTap,
    this.button,
    this.hasValue,
    this.onChange,
    this.focusNode,
    this.controller,
  });
}
