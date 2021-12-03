import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String? _currentName;
  String? _currentSugar;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth>(context);

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
                    'Update Orders',
                    style: TextStyle(fontSize: 23.0),
                  ),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    onChanged: (val) =>
                        setState(() => _currentSugar = val.toString()),
                    value: _currentSugar ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        child: Text('$sugar sugars'),
                        value: sugar,
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.0),
                  Slider(
                      value:
                          (_currentStrength ?? userData.strength)!.toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength!],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength!],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round())),
                  TextButton(
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.pink),
                    
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugar ?? userData.sugars!,
                            _currentName ?? userData.name!,
                            _currentStrength ?? userData.strength!);

                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
