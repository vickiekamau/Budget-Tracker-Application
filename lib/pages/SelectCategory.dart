import 'package:flutter/material.dart';

class Category extends StatefulWidget{//define stateful widget

  State<StatefulWidget> createState(){//override createState method

    return SelectCategory();//return the its state
  }
}
class SelectCategory extends State<Category>{//create a state called second
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
      appBar: AppBar(
        title: Text("Select Category"),
      ),
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
          onTap: () {
            debugPrint("Travel Category Selected");
            //close the screen and return the Category as the result
            Navigator.pop(context,'$_travel');
          },
        ),
        ListTile(
          leading:Icon(Icons.local_pizza),
          title: Text("$_eatOut"),
          onTap: (){
            debugPrint("Eat Out Category Selected");
            //close the Screen and return the EatOut as the result
            Navigator.pop(context,'$_eatOut');
          },
        ),
        ListTile(
            leading:Icon(Icons.style),
            title: Text("$_clothes"),
            onTap:(){
              debugPrint("Clothes Category Selected");
              //close the Screen and return the clothes as the result
              Navigator.pop(context,'$_clothes');
            }
        ),
        ListTile(
            leading:Icon(Icons.music_note),
            title: Text("$_entertainment"),
            onTap:(){
              debugPrint("Entertainment Category Selected");
              //close the screen and return the entertainment as the result
              Navigator.pop(context,'$_entertainment');

            }
        ),
        ListTile(
            leading:Icon(Icons.local_gas_station),
            title: Text("$_fuel"),
            onTap:(){
              debugPrint("Fuel Category Selected");
              //close the screen and return the Fuel as the result
              Navigator.pop(context,'$_fuel');
            }
        ),
        ListTile(
            leading:Icon(Icons.not_interested),
            title: Text("$_general"),
            onTap:(){
              debugPrint("General Category Selected");
              //close the screen and return the General as the result
              Navigator.pop(context,'$_general');
            }
        ),
        ListTile(
            leading:Icon(Icons.card_giftcard),
            title: Text("$_gift"),
            onTap:(){
              debugPrint("Gifts Category Selected");
              //close the screen and return the Gifts as the result
              Navigator.pop(context,'$_gift');
            }
        ),
        ListTile(
            leading:Icon(Icons.flight),
            title: Text("$_holiday"),
            onTap:(){
              debugPrint("Holiday Category Selected");
              //close the screen and return the Holiday as the result
              Navigator.pop(context,'$_holiday');
            }
        ),
        ListTile(
            leading:Icon(Icons.child_care),
            title: Text("$_kids"),
            onTap:(){
              debugPrint("Kids Category Selected");
              //close the screen and return the Kids as the result
              Navigator.pop(context,'$_kids');
            }
        ),
        ListTile(
            leading:Icon(Icons.shopping_cart),
            title: Text("$_shopping"),
            onTap:(){
              debugPrint("Shopping Category Selected");
              //close the screen and return the Shopping as the result
              Navigator.pop(context,'$_shopping');
            }
        ),
        ListTile(
            leading:Icon(Icons.fitness_center),
            title: Text("$_sport"),
            onTap:(){
              debugPrint("Sport Category Selected");
              //close the screen and return the Sport as the result
              Navigator.pop(context,'$_sport');
            }
        ),


      ],
    );
    return listView;
  }

}
