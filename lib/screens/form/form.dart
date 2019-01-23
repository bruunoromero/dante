import 'package:flutter/material.dart';
import 'package:dante/models/goal.dart';
import 'package:validate/validate.dart';
import 'package:dante/repositories/goal.dart';
import 'package:dante/screens/form/field_container.dart';

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
  PageController _pageController;
  GoalRepository _goalRepository;
  GlobalKey<FormState> _formKey;
  TextEditingController _dateController;
  TextEditingController _goalController;
  TextEditingController _aspectController;
  TextEditingController _howToMesureController;

  GoalFormState({this.goal}) : super() {
    _formKey = GlobalKey<FormState>();
    _goalRepository = GoalRepository();
    _pageController = PageController();
    _dateController = TextEditingController(text: goal.date);
    _goalController = TextEditingController(text: goal.title);
    _aspectController = TextEditingController(text: goal.title);
    _howToMesureController = TextEditingController(text: goal.howToMesure);
  }

  dynamic _validatePresence(String message) => (String str) {
        try {
          Validate.notBlank(str);
        } catch (e) {
          return message;
        }

        return null;
      };

  FormFieldContainer _buildTitleField() {
    return FormFieldContainer(
      hasValue: true,
      button: RaisedButton(onPressed: () {}),
      title: "hey",
      child: TextFormField(
        onSaved: (str) {
          goal.title = str;
        },
        controller: _goalController,
        validator: _validatePresence("Você deve preencer sua meta"),
        decoration: InputDecoration(
          labelText: "Qual a sua meta?",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  FormFieldContainer _buildHowToMesureField() {
    return FormFieldContainer(
      hasValue: true,
      button: RaisedButton(onPressed: () {}),
      title: "hey",
      child: TextFormField(
        onSaved: (str) {
          goal.howToMesure = str;
        },
        controller: _howToMesureController,
        validator: _validatePresence(
            "Você deve preencher como saber se atingiu sua meta"),
        decoration: InputDecoration(
          labelText: "Como saber se a meta foi antigida?",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  FormFieldContainer _buildDeadlineField(BuildContext context) {
    return FormFieldContainer(
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
            });
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            onSaved: (str) {
              goal.date = str;
            },
            controller: _dateController,
            validator:
                _validatePresence("Você deve preencer quando atingir sua meta"),
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
