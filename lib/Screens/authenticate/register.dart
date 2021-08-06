import 'package:brew_crew_flutter/Services/auth.dart';
import 'package:brew_crew_flutter/shared/constants.dart';
import 'package:brew_crew_flutter/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Function toggleView;
  Register({required this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  bool loading = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading ==true ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0,
          title: Text('Sign up to Brew Crew'),
          actions: [
            TextButton(
              onPressed: () {
                widget.toggleView();
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
                    'Sign In',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            )
          ]),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) => val!.length < 6
                        ? 'Password must have atleast 6 characters'
                        : null,
                    obscureText: true,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    onChanged: (val) {
                      password = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //validate goes to each function in the text field and if it gets null from all validate function only then the form is validate.
                        //if validate doesnt recieve null then the returned string will appear as helper text.

                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'please supply valid email';
                            loading = false;
                          });
                        }
                        //if user gets a succesful result then automatically they will be redirected to home page bcz we already have setup the authchange method.
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ))),
    );
  }
}
