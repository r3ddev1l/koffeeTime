import 'package:flutter/material.dart';
import 'package:koffee_time/models/user.dart';
import 'package:koffee_time/screens/wrapper.dart';
import 'package:koffee_time/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KoffeeTime',
        home: Wrapper(),
      ),
    );
  }
}
