import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ewallet/SizeConfig.dart';
import 'package:ewallet/Model/Expense.dart';
import 'package:ewallet/Model/Budget.dart';
import 'package:ewallet/pages/SelectCategory.dart';
import 'package:ewallet/utils/Database.dart';
import 'package:commons/commons.dart';


class ExpensePage extends StatefulWidget{
  final Expense expense;
 // final String category;
  ExpensePage(this.expense);//pass the expense object as parameter to the state of the widget

  State<StatefulWidget> createState(){
    return ExpenseState(this.expense);//return its state
  }
}
class ExpenseState extends State<ExpensePage>{

  Expense expense;
  Budget budget;
  String category;
  String _date= "Not Set";
  String _category = "";
  BoxDecoration myBoxDecoration(){//method to border the container
    return BoxDecoration(
      border: Border(left: BorderSide( color: Colors.blueAccent),//  <--- border color),

      ),
    );
  }
  ExpenseState(this.expense);
  DatabaseHelper dbHelper = DatabaseHelper();
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  Widget build(BuildContext context){
    amountController.text = expense.amount.toString();
    noteController.text = expense.note;
    return Scaffold(
      appBar:AppBar(
        title: Text("Expenses"),
      ),
      body:Builder(builder:(BuildContext context) {
        return SingleChildScrollView(
          child:Container(
            padding: EdgeInsets.all(15.0),
            child:Table(
             border: TableBorder.all(width: 1.0, color: Colors.blueAccent),
             children: [
              TableRow(
                  children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.highlight_off),
                            tooltip: 'Delete Expense',
                            onPressed: () {
                              setState(() {
                                _delete();
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.check_circle_outline),
                            tooltip: 'Save the Expense',
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
                        Text("Transaction Details")
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
                     // fit: BoxFit.contain
                      children: <Widget>[
                        Flexible(
                            flex:1,
                            child:Text("Date")
                        ),
                        Flexible(
                          flex:5,
                          child: Container(
                            //height: 100.0,
                            //width: 30.0,
                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  //side: BorderSide(color: Colors.blueAccent),
                                  borderRadius: BorderRadius.circular(1.0)),
                                  elevation: 1.0,
                                  onPressed: () {
                                  DatePicker.showDatePicker(context,
                                    theme: DatePickerTheme(
                                      //containerHeight: 20.0,
                                    ),
                                    showTitleActions: true,
                                    minTime: DateTime(2000, 1, 1),
                                    maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                                      print('confirm $date');
                                      _date = '${date.year} - ${date.month} - ${date.day}';
                                      setState(() {updateDate();});
                                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                                  },
                              child: Container(
                                //alignment: Alignment.center,
                                //height: 20.0,
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
                                              Text(" $_date",
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
                                      " Change",
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
                         child:Text("Category",
                         style: TextStyle(fontSize: 11.7),
                            ),
                         ),

                        Flexible(
                          flex: 5,
                          child:Container(
                            decoration: myBoxDecoration(),
                              child:ListTile(
                               //leading: Icon(Icons.account_balance_wallet),
                               title: Text("$_category",
                                    style: TextStyle(
                                    color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                     fontSize: 15.0),),
                                    //subtitle: Text("Enter Your Expense Transactions"),
                               //trailing: Icon(Icons.more_vert),
                                 onTap: () {
                                  //debugPrint("$_category Cat Selected");
                                   navigateToCategory(context);
                                   //updateCategory();


                              }
                            ),
                          ),
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
                          flex:1,
                          child:Text("Amount",
                          style: TextStyle(fontSize: 12.0),
                          ),
                         ),
                        Flexible(
                          flex:5,
                          child:Container(
                            //height: SizeConfig.safeBlockVertical *100,
                            //width: SizeConfig.safeBlockHorizontal * 100,
                             decoration: myBoxDecoration(),//calling method to border the container
                            child: TextField(
                              decoration:InputDecoration(
                                hintText: "0",
                              ),
                              controller: amountController,
                              onChanged: (value) {
                               debugPrint('Amount of expense typed in');
                               updateAmount();
                              },
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0
                                ),
                                /* decoration: InputDecoration(
                                //labelText: 'Description',
                                //labelStyle: textStyle,
                                  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1.0),
                                  borderSide: BorderSide(color:Colors.blueAccent),
                                   ),
                                 ),*/
                            keyboardType: TextInputType.number,
                          ),
                         ),
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
                           flex:1,
                           child:Text("Note",
                             style: TextStyle(fontSize: 12.0),
                           ),
                        ),
                        Flexible(
                           flex:5,
                           child:Container(
                             //height: SizeConfig.safeBlockVertical *100,
                             //width: SizeConfig.safeBlockHorizontal * 100,
                             //width: 300.0,
                             //height: 30.0,// do it in both Container
                             decoration: myBoxDecoration(),//calling method to border the container
                             child: TextField(

                               controller: noteController,
                             onChanged: (value) {
                              debugPrint('Something Changed in the Description Text Field');
                              updateNote();
                            },
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                              /*decoration: InputDecoration(
                              //labelText: 'Description',
                              //labelStyle: textStyle,
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              borderSide: BorderSide(color:Colors.blueAccent),
                              ),
                             ),*/
                            keyboardType: TextInputType.text,
                          ),
                         ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Text(" "),

                      ],
                    ),
                  ),
                ],
              ),
            ]
            ),
            ),
           );
          }),
        );
       }
    //A method that launches the CategoryScreen and Awaits the result from Navigator.pop
    void navigateToCategory(BuildContext context) async {//NAVIGATE TO CATEGORY PAGE
    //Navigator.push return a Future that completes after calling Navigator.pop on the Category Screen
    _category = await Navigator.push
      (context, MaterialPageRoute(builder: (context) => Category()
          ),
       );
    expense.category =_category;
    debugPrint('$_category');
    //return _category;
    }
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  /*void updateCategory(){


  }*/
  void updateDate(){
    debugPrint('$_date');
    expense.date = _date;
  }
  void updateAmount(){
   expense.amount= int.parse(amountController.text);
  }
  void updateNote(){
    expense.note = noteController.text;
  }
  Future<void> _save() async{
    var budgetAmount = (await dbHelper.getBudgetAmount());
    if(budgetAmount == null){
        errorDialog(
        context,
        "No Budget Amount Entered",
        );
        moveToLastScreen();
      }
    else {
      //moveToLastScreen();
      //note.date = DateFormat.yMMMd().format(DateTime.now());
      int result;
      if (expense.id != null) { //case 1: update operation
        result = await dbHelper.updateExpense(
            expense); //Update a budget object and save it to database
      } else {
        result = await dbHelper.insertExpense(expense); //insert operation
      }

      if (result != 0) { //success
        successDialog(
          context,
          "Expense Saved Successfully",
         );
        moveToLastScreen();
        debugPrint("Expense Saved Successfully");
      }
      else { //Failure
        errorDialog(
          context,
          "Problem Saving Expense",
        );
        debugPrint('Problem Saving Expense');
      }
    }
  }
  Future<void> _delete() async{
    moveToLastScreen();

    //Case 1: if user is trying to delete the a completely New Budget it wont delete but because there was no Budget to Call
    /*if (expense.id == null) {
      _showAlertDialog('Status', 'No Expense was Deleted');
      return;
    }
    //Case 2: user is trying to delete the old note that already have a valid ID
    int result = await dbHelper.deleteBudget(expense.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Expense Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Expense');
    }*/
  }
  void _showAlertDialog(String title,String message,BuildContext context){
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        moveToLastScreen();
      },
    );
      //set up the AlertDialog
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
        context: context,
        builder: (_) => alertDialog
     );
    }
  }
