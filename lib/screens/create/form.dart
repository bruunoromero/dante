import 'dart:async';

import 'package:dante/screens/create/how_to_mesure_field.dart';
import 'package:flutter/material.dart';
import 'package:dante/models/goal.dart';
import 'package:validate/validate.dart';
import 'package:dante/repositories/goal.dart';
import 'package:dante/screens/create/title_field.dart';
import 'package:dante/screens/create/field_container.dart';

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
  dispose() {
    super.dispose();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    if (!hasBuildedOnce) {
      _focus(_focusNodes.first);
      hasBuildedOnce = true;
    }
  }

  Function _validatePresence(String message) => (String str) {
        if (!_hasValue(str)) {
          return message;
        }
      };
  CreateFieldContainer _buildDeadlineField(BuildContext context) {
    return CreateFieldContainer(
      hasValue: true,
      title: "hey",
      child: InkWell(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: DateTime.now(),
            lastDate: DateTime(2100, 1, 1),
          );

          if (date != null) {
            setState(() {
              _dateController.text = date.toString();
              goal.date = date.toString();
            });
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: "Quando quer atingir sua meta?",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  CreateFieldContainer _buildAspectField(BuildContext context) {
    return CreateFieldContainer(
      hasValue: true,
      button: RaisedButton(onPressed: () {}),
      title: "hey",
      child: InkWell(
        onTap: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _aspectController.text = "Work";
                          goal.aspect = "Work";
                        });
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
          child: TextFormField(
            onSaved: (str) {
              goal.aspect = str;
            },
            validator: _validatePresence(
                "Você deve preencer qual aspector da sua meta"),
            controller: _aspectController,
            decoration: InputDecoration(
              labelText: "Em qual aspecto está a sua meta?",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
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
            TitleField(
              focusNode: _focusNodes[0],
              hasValue: _hasValue(goal.title),
              onNext: _nextPage,
              onChange: (str) {
                setState(() {
                  goal.title = str;
                });
              },
            ),
            HowToMesureField(
              focusNode: _focusNodes[1],
              hasValue: _hasValue(goal.howToMesure),
              onNext: _nextPage,
              onChange: (str) {
                setState(() {
                  goal.howToMesure = str;
                });
              },
            ),
            _buildDeadlineField(context),
            _buildAspectField(context),
            _buildSubmitButton(context)
          ],
        ),
      ),
    );
  }
}
