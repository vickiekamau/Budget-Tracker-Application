import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ewallet/pages/Spending.dart';
import 'package:ewallet/pages/Budget.dart';
import 'package:ewallet/pages/Expenses.dart';
import 'package:ewallet/SizeConfig.dart';
import 'package:ewallet/Model/Budget.dart';
import 'package:ewallet/Model/Expense.dart';
import 'package:ewallet/utils/Database.dart';
import 'package:sqflite/sqflite.dart';

class SpendingPage extends StatefulWidget{//define stateful widget


  State<StatefulWidget> createState(){//override createState method

    return Spending();//return the its state
  }
}
class Spending extends State<SpendingPage> {
  //create a state called second
  final ScrollController _scrollController = ScrollController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Budget> budgetList;
  int count = 0;
  int _total = 0;
  int _budAmount = 0;
  int _balance = 0;
  List<Expense> expenseList;
  Budget budget;
  Expense expense;

  Widget build(BuildContext build) {
    //override build method

    if ((budgetList == null) && (expenseList == null)) {
      budgetList = List<Budget>();
      expenseList = List<Expense>();
    }
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

      ],
    );

    return Scaffold(

      body: Builder(builder: (BuildContext context) {
        calcExpense();
        calcBudget();
        //calcBalance();
        return Scaffold(
             body: Container(
               padding: EdgeInsets.all(20),
                child: Column(

                  children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Text('Bugdet', style: TextStyle(fontSize: 16),),
                       Text('KSHS ' + _budAmount.toString(),
                        style: TextStyle(fontSize: 16),),
                    ],
                   ),
                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      Text('Expense Total', style: TextStyle(fontSize: 16),),
                      Text('KSHS ' + _total.toString(),
                      style: TextStyle(fontSize: 16),)
                    ],
                  ),
                      Expanded(
                          child:Scrollbar(
                            //scrollbarColor: Theme.of(context).accentColor.withOpacity(0.75),
                             // isAlwaysShown: true,
                              child: getListView(
                              ),
                        ),
                      ),

                     Padding(
                         padding: EdgeInsets.only(top: 10.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text('Balance', style: TextStyle(fontSize: 16),),
                           Text('KSHS ' + _balance.toString(),
                             style: TextStyle(fontSize: 16),),
                         ],
                       ),
                     ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                             //Expense button

                              RaisedButton(
                               color: Theme
                                 .of(context)
                                 .primaryColorDark,
                                textColor: Theme
                                 .of(context)
                                 .primaryColorLight,
                                 child: Text('Expense',textScaleFactor: 1.0,),
                               onPressed: () {
                                if(mounted) {
                                    setState(() {
                                   debugPrint("Expense Button Clicked");
                                navigateToExpense(Expense('',0,'','2020-04-14'));
                                   });
                                  }
                                },
                              ),


                                 //Budget button

                              RaisedButton(
                                color: Theme
                                .of(context)
                                .primaryColorDark,
                                textColor: Theme
                                .of(context)
                                .primaryColorLight,
                                  child: Text(
                                         'Budget',
                                         textScaleFactor: 1.0,
                                   ),
                                   onPressed: () {
                                      if(mounted) {
                                        setState(() {
                                        debugPrint("Budget Button Clicked");
                                       navigateToBudget(Budget(0,'','2020-04-14'));
                                        });
                                      }
                                     },
                                   ),
                                ],
                              ),
                             ),
                           ],
                          ),
                        ),
                     );
                   }),
               );
           }
    ListView getListView() {
    //creating the list view function
      updateListView();

    //return list view using the builder function
    return ListView.builder(

      shrinkWrap: true,
      controller: _scrollController,
     // physics: const NeverScrollableScrollPhysics(),
      itemCount: count, //define item count
      itemBuilder: (BuildContext context, int position) { //define item builder
        Widget column1 = Expanded(
          child: Column(
            // align the text to the left instead of centered
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.expenseList[position].category, style: TextStyle(fontSize: 16),),
            ],
          ),
        );
        Widget column2 = Expanded(
          child: Column(
            // align the text to the left instead of centered
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("KSHS "+this.expenseList[position].amount.toString(), style: TextStyle(fontSize: 16),),
            ],
          ),
        );

              return Container(
                    child: Padding(
                     padding: const EdgeInsets.only(left:35.0,top:10.0,right:35.0),
                       child: Row(
                          children: <Widget>[
                              column1,
                              column2,
                          ],
                        ),
                      ),
                   );
                 },
        );
      //return null;
    }
      //function to define snackbar
  void _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
  void navigateToExpense(Expense expense) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){//here we will pass in the context where we will define a function where we will return an instance of a class where we want to navigate to
      return ExpensePage(expense);
    }));
    //material page route takes builder attribute as a parameter
    if(result == true){
      updateListView();
    }
  }
  void navigateToBudget(Budget budget) async {
    Navigator.push(
      context, MaterialPageRoute(builder: (Context) => BudgetPage(budget)
    ),
    );
  }
  void updateListView(){//method to update the list view
    final Future<Database> dbFuture = databaseHelper.initDB();
    dbFuture.then((database){
      Future<List<Expense>> expenseListFuture = databaseHelper.getExpenseList();
      expenseListFuture.then((expenseList){
        if(mounted) {
          setState(() {
            this.expenseList = expenseList;
            this.count = expenseList.length;
          });
        }
      });
    });
  }
    Future<int> calcExpense() async{
    int total = (await databaseHelper.getTotalExpense());
    //print(total);
    if(total == null){
      if(mounted) {
        setState(() {
          _total = 0;
        });
      }
    }
    else {
      if(mounted) {
        setState(() {
          _total = total;
        });
      }
    }
    //print(_total);

  }
  void calcBudget() async{
    var budgetAmount = (await databaseHelper.getBudgetAmount());
    if(budgetAmount == null){
      if(mounted) {
        setState(() {
          _budAmount = 0;
        });
      }
    }
    else{
      if(mounted) {
        setState(() {
          _budAmount = budgetAmount;
        });
       }
      }
   // print(_budAmount);
    }
    void calcBalance() async{
      var totalExpense = (await databaseHelper.getTotalExpense());
      var budgetAmount = (await databaseHelper.getBudgetAmount());
      if(budgetAmount == 0 && totalExpense == 0){
        if(mounted){
            setState(() {
             _balance = 0;
            });
        }
       }
    else{
        var balanceAmount =  budgetAmount - totalExpense;
        if(mounted){
          setState(() {
          _balance = balanceAmount;
        });
      }
    }


    }
 }