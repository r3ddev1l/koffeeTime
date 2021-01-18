import 'package:flutter/material.dart';
import 'package:koffee_time/models/koffee.dart';
import 'package:koffee_time/screens/home/koffee_tile.dart';
import 'package:provider/provider.dart';

class KoffeeList extends StatefulWidget {
  @override
  _KoffeeListState createState() => _KoffeeListState();
}

class _KoffeeListState extends State<KoffeeList> {
  @override
  Widget build(BuildContext context) {
    final koffees = Provider.of<List<Koffee>>(context) ?? [];
    koffees.forEach((koffee) {
      print(koffee.name);
      print(koffee.sugar);
      print(koffee.strenght);
    });

    return ListView.builder(
        itemCount: koffees.length,
        itemBuilder: (context, index) {
          return KoffeeTile(koffee: koffees[index]);
        });
  }
}
