import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loding.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function()? press;
  SignIn({this.press});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text('Sign in to Brew Crew'),
              actions: [
                TextButton(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: widget.press,
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a valid an email' : null,
                      onChanged: (val) => setState(() => email = val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Please enter a valid password'
                          : null,
                      onChanged: (val) => setState(
                        () => password = val,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          UserAuth? result = await AuthServices()
                              .signInWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error = 'invalid Credentail';
                              loading = false;
                            });
                          }
                        }
                        print(email);
                        print(password);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.pink[400]),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 15.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
