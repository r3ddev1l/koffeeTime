import 'package:flutter/material.dart';
import 'package:koffee_time/models/koffee.dart';
import 'package:koffee_time/screens/home/koffee_list.dart';
import 'package:koffee_time/screens/home/settings_form.dart';
import 'package:koffee_time/services/auth.dart';
import 'package:koffee_time/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Koffee>>.value(
      value: DatabaseService().koffee,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("KoffeeTime"),
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Sign Out"),
            ),
            FlatButton.icon(
              onPressed: _showSettingsPanel,
              icon: Icon(Icons.settings),
              label: Text("Preference"),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover),
          ),
          child: KoffeeList(),
        ),
      ),
    );
  }
}
