import 'package:flutter/material.dart';
import 'package:ewallet/pages/Spending.dart';
import 'package:ewallet/SizeConfig.dart';

class HomePage extends StatefulWidget{//define stateful widget

  State<StatefulWidget> createState(){//override createState method

    return Home();//return the its state
  }
}
class Home extends State<HomePage>{//create a state called second

  Widget build(BuildContext build){//override build method
    SizeConfig().init(build);
    var dots = Row(

      children: [
        Icon(Icons.more_horiz, color: Colors.black),
        Icon(Icons.more_horiz, color: Colors.black),
        Icon(Icons.more_horiz, color: Colors.black),
        Icon(Icons.more_horiz, color: Colors.black),
        Icon(Icons.more_horiz, color: Colors.black),
        Icon(Icons.more_horiz, color: Colors.black),
        Icon(Icons.more_horiz, color: Colors.black),
        Icon(Icons.more_horiz, color: Colors.black),
        Icon(Icons.more_horiz, color: Colors.black),
        Icon(Icons.more_horiz, color: Colors.black),
        //Icon(Icons.more_horiz, color: Colors.black),
        //Icon(Icons.more_horiz, color: Colors.black),
        //Icon(Icons.more_horiz, color: Colors.black),
        //Icon(Icons.more_horiz, color: Colors.black),
        //Icon(Icons.more_horiz, color: Colors.black),
      ],
    );
    return Scaffold(
      //appBar: AppBar(
      // title: Text("Edit Note"),
      // ),
      body: Container(
           height: SizeConfig.safeBlockVertical *100,
           width: SizeConfig.safeBlockHorizontal * 100,
           padding: EdgeInsets.all(20),
           child: Column(

            children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children :[
              Text('Bugdet'),
              Text('KSH 10000')
               ],
              ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text('Expense Total'),
                    Text('KSH 10000')
                 ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Travel'),
                 Text('KSH 10000')
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Eating Out'),
                 Text('KSH 10000')
               ],
             ),
            SingleChildScrollView(
              child: dots,
            ),

           ],
          ),


        ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: (){//when user click on the navigation button let us go to the Navigator widget
          debugPrint('FAB clicked');
          //SpendingPage();
        },
      ),
    );
    }
    //return null;
  }
