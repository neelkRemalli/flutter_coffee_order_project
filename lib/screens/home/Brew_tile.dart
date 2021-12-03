import 'package:brew_crew/model/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew? brew;
  const BrewTile({Key? key, this.brew}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
        ),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.brown[brew!.strength],
              backgroundImage: AssetImage('assets/coffee_icon.png'),
              radius: 25,
            ),
            title: Text(brew!.name),
            subtitle: Text('Sugar ${brew!.sugars}'),
          ),
        ),
      ),
    );
  }
}
