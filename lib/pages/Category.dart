import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget{//define stateful widget

  State<StatefulWidget> createState(){//override createState method

    return Category();//return the its state
  }
}
class Category extends State<CategoryPage>{//create a state called second
  String _travel = "Travel";
  String _eatOut = "Eating Out" ;
  String _clothes = "Clothes";
  String _entertainment = "Entertainment";
  String _fuel = "Fuel";
  String _general = "General";
  String _gift = "Gifts";
  String _holiday = "Holiday";
  String _kids = "Kids";
  String _shopping = "Shopping";
  String _sport = "Sports";

  Widget build(BuildContext build){//override build method

    return Scaffold(
      body: getListView(),
    );
    //return null;
  }
  Widget getListView(){
    var listView = ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.directions_bus),
          title: Text("$_travel"),
        ),
        ListTile(
          leading:Icon(Icons.local_pizza),
          title: Text("$_eatOut"),
        ),
        ListTile(
          leading:Icon(Icons.style),
          title: Text("$_clothes"),
        ),
        ListTile(
          leading:Icon(Icons.music_note),
          title: Text("$_entertainment"),
        ),
        ListTile(
          leading:Icon(Icons.local_gas_station),
          title: Text("$_fuel"),
        ),
        ListTile(
          leading:Icon(Icons.not_interested),
          title: Text("$_general"),
        ),
        ListTile(
          leading:Icon(Icons.card_giftcard),
          title: Text("$_gift"),
        ),
        ListTile(
          leading:Icon(Icons.flight),
          title: Text("$_holiday"),
        ),
        ListTile(
          leading:Icon(Icons.child_care),
          title: Text("$_kids"),
        ),
        ListTile(
          leading:Icon(Icons.shopping_cart),
          title: Text("$_shopping"),
        ),
        ListTile(
          leading:Icon(Icons.fitness_center),
          title: Text("$_sport"),
        ),
      ],
    );
    return listView;
  }

}
