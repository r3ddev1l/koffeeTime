import 'package:flutter/material.dart';
import 'package:koffee_time/services/auth.dart';
import 'package:koffee_time/shared/constants.dart';
import 'package:koffee_time/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  // textfield state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Sign In To KoffeeTime"),
              actions: [
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text("Register"),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    //email
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Email"),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) =>
                          val.isEmpty ? "Enter a valid email" : null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //password
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Password"),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val) => val.length < 6
                          ? "Password should be atleast 6 characters long"
                          : null,
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          if (result == null) {
                            setState(() {
                              error =
                                  "Could not sign in with those credentials!";
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.brown,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
