import 'package:brew_crew_flutter/Screens/authenticate/authenticate.dart';
import 'package:brew_crew_flutter/Screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_flutter/models/Profile.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Profile?>(context);
    
    //return Home or Authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }  
  }
}
