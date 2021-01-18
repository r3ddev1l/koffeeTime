import 'package:flutter/material.dart';
import 'package:koffee_time/models/user.dart';
import 'package:koffee_time/services/database.dart';
import 'package:koffee_time/shared/constants.dart';
import 'package:koffee_time/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Update your koffee preference",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //name
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //sugar dropdown
                    DropdownButtonFormField(
                        decoration: textInputDecoration,
                        value: _currentSugars ?? userData.sugar,
                        items: sugars
                            .map(
                              (sugar) => DropdownMenuItem(
                                value: sugar,
                                child: Text('$sugar sugars'),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _currentSugars = val;
                          });
                        }),

                    //strength slider
                    Slider(
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      onChanged: (val) => setState(
                        () => _currentStrength = val.round(),
                      ),
                    ),
                    //done button
                    RaisedButton(
                      color: Colors.brown,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              name: _currentName ?? userData.name,
                              sugar: _currentSugars ?? userData.sugar,
                              strength: _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
