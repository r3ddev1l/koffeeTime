import 'package:flutter/material.dart';
import 'package:koffee_time/models/koffee.dart';

class KoffeeTile extends StatelessWidget {
  final Koffee koffee;

  KoffeeTile({this.koffee});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            backgroundColor: Colors.brown[koffee.strenght],
          ),
          title: Text(koffee.name),
          subtitle: Text('Takes ${koffee.sugar} sugar(s)'),
        ),
      ),
    );
  }
}
