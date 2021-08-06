import 'package:brew_crew_flutter/Screens/home/brew_list.dart';
import 'package:brew_crew_flutter/Screens/home/settings_form.dart';
import 'package:brew_crew_flutter/Services/auth.dart';
import 'package:brew_crew_flutter/models/Profile.dart';
import 'package:brew_crew_flutter/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_flutter/Services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Profile?>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Provider(
                create: (_) => Profile(uid: user!.uid),
                child: SettingsForm(),
              ),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: user!.uid).brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                _auth.signOut();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                _showSettingsPanel();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          child: BrewList(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/coffee_bg.png'))),
        ),
      ),
    );
  }
}
