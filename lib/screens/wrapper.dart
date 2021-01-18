import 'package:flutter/material.dart';
import 'package:koffee_time/models/user.dart';
import 'package:koffee_time/screens/authenticate/authenticate.dart';
import 'package:koffee_time/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return authenticate or home
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
