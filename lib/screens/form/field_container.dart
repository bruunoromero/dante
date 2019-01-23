import 'package:flutter/material.dart';

class FormFieldContainer extends StatefulWidget {
  final Widget child;
  final String title;
  final Widget button;
  final bool hasValue;

  const FormFieldContainer({this.title, this.child, this.button, this.hasValue})
      : super();

  @override
  FormFieldContainerState createState() {
    return FormFieldContainerState();
  }
}

class FormFieldContainerState extends State<FormFieldContainer>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  animate() {
    if (widget.hasValue) {
      _animationController.forward();
    } else {
      _animationController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    animate();
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
                    child: Text(widget.title),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 32),
                    child: widget.child,
                  ),
                ],
              ),
            ),
            Container(
              child: FadeTransition(
                opacity: _animation,
                child: widget.button,
              ),
            )
          ],
        ),
      ),
    );
  }
}
