import 'package:brew_crew_flutter/Screens/wrapper.dart';
import 'package:brew_crew_flutter/Services/database.dart';
import 'package:brew_crew_flutter/models/Profile.dart';
import 'package:brew_crew_flutter/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_flutter/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values

  String _currentName = '';
  String _currentSugars = '';
  int _currentStrength = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Profile>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) {
                      setState(() {
                        _currentName = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  //dropdown
                  DropdownButtonFormField(
                      decoration: textInputDecoration.copyWith(
                        labelText: userData.sugars,
                      ),
                      onChanged: (val) {
                        setState(() {
                          _currentSugars = val.toString().substring(0, 1);
                        });
                      },
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          child: Text('$sugar sugars'),
                          value: sugar,
                        );
                      }).toList()),
                  //slider
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    value: (_currentStrength == 0
                                  ? userData.strength
                                  : _currentStrength).toDouble(),
                    activeColor: Colors.brown[_currentStrength == 0
                                  ? userData.strength
                                  : _currentStrength],
                    inactiveColor: Colors.brown[_currentStrength == 0
                                  ? userData.strength
                                  : _currentStrength],
                    onChanged: (val) {
                      setState(() {
                        _currentStrength = val.round();
                      });
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars == ''
                                  ? userData.sugars
                                  : _currentSugars,
                              _currentName == '' ? userData.name : _currentName,
                              _currentStrength == 0
                                  ? userData.strength
                                  : _currentStrength);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
