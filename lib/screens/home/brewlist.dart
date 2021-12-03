// import 'package:brew_crew/model/brew.dart';
// import 'package:brew_crew/screens/home/Brew_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class BrewList extends StatefulWidget {
//   BrewList({Key? key}) : super(key: key);

//   @override
//   _BrewListState createState() => _BrewListState();
// }

// class _BrewListState extends State<BrewList> {
//   @override
//   Widget build(BuildContext context) {
//     final brews = Provider.of<List<Brew>?>(context) ?? [];

//     brews.forEach((element) {
//       print(element.name);
//       print(element.sugars);
//       print(element.strength);
//     });

//     return ListView.builder(
//       itemCount: brews.length,
//       itemBuilder: (context, index) => BrewTile(brew: brews[index]),
//     );
//   }
// }
import 'package:brew_crew/model/brew.dart';
import 'package:brew_crew/screens/home/Brew_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context) ?? [];
   
    return Container(
        child: ListView.builder(
            itemCount: brews.length,
            itemBuilder: (context, index) => BrewTile(brew: brews[index])),
        );
  }
}
