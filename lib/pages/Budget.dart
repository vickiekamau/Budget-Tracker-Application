import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ewallet/utils/Database.dart';
import 'package:ewallet/Model/Budget.dart';
import 'package:commons/commons.dart';


class BudgetPage extends StatefulWidget{

  final Budget budget;
  BudgetPage(this.budget);//pass the budget object as parameter to the state of the widget

  State<StatefulWidget> createState(){
   return BudgetState(this.budget);//return its state
  }
}
class BudgetState extends State<BudgetPage>{
   Budget budget;
   String _date = "Not set";
   //define constructor between Budget state
   BudgetState(this.budget);
   DatabaseHelper dbHelper = DatabaseHelper();
   TextEditingController amountController = TextEditingController(); //controlling the values entered to the application
   TextEditingController noteController = TextEditingController();

  Widget build(BuildContext context){
       BoxDecoration myBoxDecoration() {//method to border the container
          return BoxDecoration(
          border: Border(left: BorderSide( color: Colors.blueAccent),//  <--- border color),
          ),
         );
        }
      amountController.text = budget.amount.toString();
      noteController.text = budget.note;
    return Scaffold(
      appBar:AppBar(
       title: Text("Budget"),
        ),
       body: Builder(builder: (BuildContext context){

         return SingleChildScrollView(
             child:Container(
              padding: EdgeInsets.all(15.0),
               child:Table(
                border: TableBorder.all(width:1.0,color: Colors.blueAccent),
                 children: [
                 TableRow(
                 children: [
                   TableCell(
                      child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.highlight_off),
                            tooltip: 'Delte Budget',
                            onPressed: () {
                              setState(() {
                                _delete();
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.check_circle_outline),
                            tooltip: 'Save Budget Details',
                            onPressed: () {
                              setState(() {
                                _save();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ]

                ),
                TableRow(
                 children: [
                   TableCell(
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       Flexible(
                         flex: 3,
                         child:Text("Transaction Details")
                       ),
                      ],
                     ),
                   ),
                 ],
                 ),
                 TableRow(
                children: [
                 TableCell(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Flexible(
                            flex: 1,
                            child:Text("Date",
                             style:TextStyle(fontSize: 12.0),
                            ),
                           ),
                         Flexible(
                             flex: 5,
                            child:Container(
                             //width: 300.0,
                             //height: 30.0,
                               child: RaisedButton(
                                 color: Colors.white,
                                 shape: RoundedRectangleBorder(
                                 //side: BorderSide(color: Colors.blueAccent),
                                 borderRadius: BorderRadius.circular(1.0)),
                                 elevation: 1.0,
                                 onPressed: () {
                                   DatePicker.showDatePicker(context,
                                   theme: DatePickerTheme(
                                     //containerHeight: 210.0,
                                   ),
                                   showTitleActions: true,
                                   minTime: DateTime(2000, 1, 1),
                                   maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                                     print('confirm $date');
                                     _date = '${date.year}-${date.month}-${date.day}';
                                     setState(() {updateDate();});
                                   }, currentTime: DateTime.now(), locale: LocaleType.en);
                                 },
                                  child: Container(
                                   alignment: Alignment.center,
                                      // height: 50.0,
                                      child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: <Widget>[
                                       Row(
                                        children: <Widget>[
                                         Container(
                                           child: Row(
                                            children: <Widget>[
                                              Icon(
                                               Icons.date_range,
                                               size: 18.0,
                                               color: Colors.blueAccent,
                                               ),
                                              Text("$_date",
                                               style: TextStyle(
                                                   color: Colors.blueAccent,
                                                   fontWeight: FontWeight.bold,
                                                   fontSize: 15.0),
                                              ),
                                             ],
                                            ),
                                           ),
                                         ],
                                        ),
                                        Text(
                                          "Change",
                                          style: TextStyle(
                                         color: Colors.blueAccent,
                                         fontWeight: FontWeight.bold,
                                         fontSize: 15.0),
                                   ),
                                 ],
                               ),
                             ),
                             //color: Colors.white,
                           ),

                          ),
                          ),
                       ],
                     ),
                   ),
                  ]
                 ),

                TableRow(
                children: [
                 TableCell(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Flexible(
                           flex: 1,
                           child:Text("Amount",
                             style:TextStyle(fontSize: 12),
                            ),
                          ),
                          Flexible(
                             flex:5,
                                child:Container(
                                 //width: 300.0,
                                   // height: 30.0,// do it in both Container
                                    decoration: myBoxDecoration(),//calling method  to border the container
                                  child: TextField(
                                    decoration:InputDecoration(
                                      hintText: "0",
                                    ),
                                    controller: amountController,
                                   onChanged: (value) {
                                   debugPrint('Amount Entered');
                                     updateAmount();
                                     },
                                   style: TextStyle(
                                   color: Colors.blueAccent,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 15.0),
                                   /*: InputDecoration(
                                   //labelText: 'Description',
                                   //labelStyle: textStyle,
                                   border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(1.0),
                                   borderSide:  BorderSide(color:Colors.blueAccent),
                                   ),
                                   ),*/
                                    keyboardType: TextInputType.number,
                                 ),
                              ),
                              ),
                            ],
                          ),
                        ),
                       ]
                     ),
                TableRow(
                children: [
                  TableCell(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Flexible(
                           flex:1,
                           child:Text("Note",
                           style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                         Flexible(
                           flex:5,
                           child:Container(
                           //width: 300.0,
                           //height: 30.0,// do it in both Container
                             decoration: myBoxDecoration(),//calling method  to border the container
                              child: TextField(
                                controller: noteController,
                               onChanged: (value) {
                               debugPrint('A description of the Category');
                               updateNote();
                               },
                                 style: TextStyle(
                                 color: Colors.blueAccent,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 15.0),
                                 /* decoration: InputDecoration(
                                 //labelText: 'Description',
                                 //labelStyle: textStyle,
                                  border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(1.0),
                                   borderSide:  BorderSide(color:Colors.blueAccent),
                                 ),
                                ),*/
                             keyboardType: TextInputType.text,
                             ),
                             ),
                            ),
                          ],
                     ),
                   ),
                  ]
                 ),
                 TableRow(
                 children: [
                 TableCell(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text("")
                     ],
                    ),
                   ),
                 ],
               ),
               ],
              )
             ),
           );
          }
         ),
       );
  }
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateDate(){
    debugPrint('$_date');
     budget.date = _date;
  }
  void updateAmount(){
      budget.amount= int.parse(amountController.text);
  }
  void updateNote(){
       budget.note = noteController.text;
  }
   Future<void> _save() async{
     var now = new DateTime.now();
     var formatter = new DateFormat('yyyy-MM');
     String month = formatter.format(now);
    moveToLastScreen();
    //note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (budget.id != null) { //case 1: update operation
      result = await dbHelper.updateBudget(budget); //Update a budget object and save it to database
           print(month);

    } else if(budget.id == null) {
      result = await dbHelper.insertBudget(budget);//insert operation
    }

    if (result != 0) { //success
      successDialog(
        context,
        "Budget Saved Successfully",
      );
      debugPrint('Budget Saved Successfully');
    }
    else { //Failure
      errorDialog(context, "Problem Saving Budget");
      debugPrint('Problem Saving Successfully');
    }
  }
   Future<void> _delete() async{
    moveToLastScreen();

    //Case 1: if user is trying to delete the a completely New Budget it wont delete but because there was no Budget to Call
    /*if (budget.id == null) {
      _showAlertDialog('Status', 'No Budget was Deleted');
      return;
    }
    //Case 2: user is trying to delete the old note that already have a valid ID
    int result = await dbHelper.deleteBudget(budget.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Budget Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Budget');
    }*/
  }
  void _showAlertDialog(String title,String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog
    );
  }
}