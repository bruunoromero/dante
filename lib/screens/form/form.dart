import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dante/models/goal.dart';
import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'package:dante/screens/form/field_container.dart';

class GoalForm extends StatefulWidget {
  final String id;
  final String date;
  final String title;
  final String aspect;
  final String howToMesure;

  const GoalForm({
    this.id,
    this.date,
    this.title,
    this.aspect,
    this.howToMesure,
  }) : super();

  @override
  GoalFormState createState() {
    return GoalFormState();
  }

  static GoalForm of(Goal goal) {
    return GoalForm(
      id: goal.id,
      date: goal.date,
      title: goal.title,
      aspect: goal.aspect,
      howToMesure: goal.howToMesure,
    );
  }
}

class GoalFormState extends State<GoalForm> {
  final String goalId;
  Map<String, dynamic> _data;
  GlobalKey<FormState> _formKey;
  TextEditingController _dateController;
  TextEditingController _goalController;
  TextEditingController _aspectController;
  TextEditingController _howToMesureController;

  GoalFormState({
    this.goalId,
    String date,
    String title,
    String aspect,
    String howToMesure,
  }) : super() {
    _data = Map<String, dynamic>();
    _formKey = GlobalKey<FormState>();
    _dateController = TextEditingController(text: date);
    _goalController = TextEditingController(text: title);
    _aspectController = TextEditingController(text: title);
    _howToMesureController = TextEditingController(text: howToMesure);
  }

  dynamic _validatePresence(String message) => (String str) {
        try {
          Validate.notBlank(str);
        } catch (e) {
          return message;
        }

        return null;
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormFieldContainer(
              child: TextFormField(
                onSaved: (str) {
                  _data['title'] = str;
                },
                controller: _goalController,
                validator: _validatePresence("Você deve preencer sua meta"),
                decoration: InputDecoration(
                  labelText: "Qual a sua meta?",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            FormFieldContainer(
              child: TextFormField(
                onSaved: (str) {
                  _data['howToMesure'] = str;
                },
                controller: _howToMesureController,
                validator: _validatePresence(
                    "Você deve preencher como saber se atingiu sua meta"),
                decoration: InputDecoration(
                  labelText: "Como saber se a meta foi antigida?",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            FormFieldContainer(
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
                      _data['date'] = str;
                    },
                    controller: _dateController,
                    validator: _validatePresence(
                        "Você deve preencer quando atingir sua meta"),
                    decoration: InputDecoration(
                      labelText: "Quando quer atingir sua meta?",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            FormFieldContainer(
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
                      _data['aspect'] = str;
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
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        await Firestore.instance.collection('okrs').add(_data);

                        Navigator.pop(context);
                      }
                    },
                    child: Text("Criar"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
