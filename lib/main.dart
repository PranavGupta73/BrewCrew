import 'package:brew_crew_flutter/Screens/wrapper.dart';
import 'package:brew_crew_flutter/Services/auth.dart';
import 'package:brew_crew_flutter/models/Profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Profile?>.value(
      catchError: (_,__)=>null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp( 
       home: Wrapper(),
      ),
    );
  }
}
