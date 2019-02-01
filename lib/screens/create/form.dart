import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dante/models/goal.dart';
import 'package:validate/validate.dart';
import 'package:dante/repositories/goal.dart';
import 'package:dante/screens/create/title_field.dart';
import 'package:dante/screens/create/aspect_field.dart';
import 'package:dante/screens/create/deadline_field.dart';
import 'package:dante/screens/create/how_to_mesure_field.dart';

class CreateGoalForm extends StatefulWidget {
  final Goal goal;

  const CreateGoalForm({this.goal}) : super();

  @override
  CreateGoalFormState createState() {
    final _goal = goal == null ? Goal() : goal;
    return CreateGoalFormState(goal: _goal);
  }
}

class CreateGoalFormState extends State<CreateGoalForm> {
  Goal goal;
  bool hasBuildedOnce = false;
  List<FocusNode> _focusNodes;
  PageController _pageController;
  GoalRepository _goalRepository;
  GlobalKey<FormState> _formKey;
  TextEditingController _dateController;
  TextEditingController _aspectController;

  CreateGoalFormState({this.goal}) : super() {
    _formKey = GlobalKey<FormState>();
    _goalRepository = GoalRepository();
    _pageController = PageController();
    _dateController = TextEditingController(text: goal.date);
    _aspectController = TextEditingController(text: goal.aspect);
    _focusNodes = [FocusNode(), FocusNode(), FocusNode(), FocusNode()];
  }

  _focus(FocusNode next) {
    if (next != null) {
      Future.delayed(Duration(milliseconds: 500), () {
        FocusScope.of(context).requestFocus(next);
      });
    }
  }

  void _nextPage() {
    final page = _pageController.page.floor();

    _focus(_focusNodes[page + 1]);

    _pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  bool _hasValue(String str) {
    try {
      Validate.notBlank(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    if (!hasBuildedOnce) {
      _focus(_focusNodes.first);
      hasBuildedOnce = true;
    }
  }

  TitleField _buildTitleField() {
    return TitleField(
      focusNode: _focusNodes[0],
      hasValue: _hasValue(goal.title),
      button: RaisedButton(
        onPressed: _nextPage,
      ),
      onChange: (str) {
        setState(() {
          goal.title = str;
        });
      },
    );
  }

  HowToMesureField _buildHowToMesureField() {
    return HowToMesureField(
      focusNode: _focusNodes[1],
      hasValue: _hasValue(goal.howToMesure),
      button: RaisedButton(
        onPressed: _nextPage,
      ),
      onChange: (str) {
        setState(() {
          goal.howToMesure = str;
        });
      },
    );
  }

  DeadlineField _buildDeadlineField() {
    return DeadlineField(
      controller: _dateController,
      hasValue: _hasValue(goal.date),
      button: RaisedButton(
        onPressed: _nextPage,
      ),
      onChange: (date) {
        setState(() {
          goal.date = date.toString();
          _dateController.text = goal.date;
        });
      },
      onTap: (context) {
        return showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          initialDate: DateTime.now(),
          lastDate: DateTime(2100, 1, 1),
        );
      },
    );
  }

  AspectField _buildAspectField() {
    return AspectField(
      controller: _aspectController,
      hasValue: _hasValue(goal.aspect),
      button: RaisedButton(
        onPressed: () {},
      ),
      onChange: (str) {
        setState(() {
          goal.aspect = str;
          _aspectController.text = goal.aspect;
        });
      },
      onTap: (builder) {
        showModalBottomSheet(context: context, builder: builder);
      },
    );
  }

  Row _buildSubmitButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                await _goalRepository.create(goal);

                Navigator.pop(context);
              }
            },
            child: Text("Criar"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          scrollDirection: Axis.vertical,
          children: [
            _buildTitleField(),
            _buildHowToMesureField(),
            _buildDeadlineField(),
            _buildAspectField(),
            _buildSubmitButton(context)
          ],
        ),
      ),
    );
  }
}
