import 'package:flutter/material.dart';
import 'package:dante/goals/models/goal.dart';
import 'package:validate/validate.dart';
import 'package:dante/goals/screens/form/field_container.dart';

class GoalForm extends StatefulWidget {
  final Goal goal;

  const GoalForm({this.goal}) : super();

  @override
  GoalFormState createState() {
    final _goal = goal == null ? Goal() : goal;
    return GoalFormState(goal: _goal);
  }
}

class GoalFormState extends State<GoalForm> {
  Goal goal;
  GlobalKey<FormState> _formKey;
  PageController _pageController;

  GoalFormState({this.goal}) : super() {
    _formKey = GlobalKey<FormState>();
    _pageController = PageController();
    _pageController.addListener(_dismissKeyboard);
  }

  bool _hasValue(String str) {
    try {
      Validate.notBlank(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  Function _validatePresence(String message) => (String str) {
        if (!_hasValue(str)) {
          return message;
        }
      };

  void _dismissKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  FormFieldContainer _buildTitleField() {
    return FormFieldContainer(
      hasValue: _hasValue(goal.title),
      button: RaisedButton(
        onPressed: () {},
      ),
      title: "hey",
      child: TextField(
        onChanged: (str) {
          setState(() {
            goal.title = str;
          });
        },
        decoration: InputDecoration(
          labelText: "Qual a sua meta?",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  FormFieldContainer _buildHowToMesureField() {
    return FormFieldContainer(
      hasValue: _hasValue(goal.howToMesure),
      button: RaisedButton(onPressed: () {}),
      title: "hey",
      child: TextField(
        onChanged: (str) {
          setState(() {
            goal.howToMesure = str;
          });
        },
        decoration: InputDecoration(
          labelText: "Como saber se a meta foi antigida?",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  FormFieldContainer _buildDeadlineField(BuildContext context) {
    return FormFieldContainer(
      // hasValue: _hasValue(goal.date),
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
              // goal.date = date.toString();
            });
          }
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              labelText: "Quando quer atingir sua meta?",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  FormFieldContainer _buildAspectField(BuildContext context) {
    return FormFieldContainer(
      hasValue: _hasValue(goal.aspect),
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
          child: TextField(
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
                // await _goalRepository.create(goal);

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
            _buildDeadlineField(context),
            _buildAspectField(context),
            _buildSubmitButton(context)
          ],
        ),
      ),
    );
  }
}
