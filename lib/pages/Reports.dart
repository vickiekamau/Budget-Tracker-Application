import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget{//define stateful widget

  State<StatefulWidget> createState(){//override createState method

    return Report();//return the its state
  }
}
class Report extends State<ReportPage>{//create a state called second

  Widget build(BuildContext build){//override build method

    return Scaffold(
      //appBar: AppBar(
      // title: Text("Edit Note"),
      // ),
      body: Center(
        child: Text('Reports'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
    //return null;
  }
}