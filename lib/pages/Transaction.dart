import 'package:flutter/material.dart';
import 'package:ewallet/pages/Budget.dart';
import 'package:ewallet/pages/Expenses.dart';
import 'package:ewallet/Model/Budget.dart';
import 'package:ewallet/Model/Expense.dart';

class TransactionPage extends StatefulWidget{//define stateful widget

  State<StatefulWidget> createState(){//override createState method

    return Transaction();//return the its state
  }
}
class Transaction extends State<TransactionPage> {
    Budget budget;
    Expense expense;
   // String category = "";
  //create a state called second

  Widget build(BuildContext build) {
    //override build method
    Budget budget;
    Expense expense;
    return Scaffold(
      //appBar: AppBar(
      // title: Text("Edit Note"),
      // ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text("Budget"),
              subtitle: Text("Enter Your Budget Amount"),
              trailing: Icon(Icons.more_vert),
              onTap: () {
                debugPrint("Budget Class Selected");
                navigateToBudget(Budget(0,'','2020-04-14'));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("Expense"),
              subtitle: Text("Enter Your Expense Transactions"),
              trailing: Icon(Icons.more_vert),
              onTap: () {
                debugPrint("Expense Page Selected");
                navigateToExpense(Expense('',0,'','2020-04-14'));
              },
            ),
          ],
        ),
      ),
    );
    //return null;
  }

  void navigateToBudget(Budget budget) async {
    Navigator.push(
      context, MaterialPageRoute(builder: (Context) => BudgetPage(budget)
     ),
    );
  }

  //material page route takes builder attribute as a parameter
  void navigateToExpense(Expense expense) async {
    Navigator.push(
      context, MaterialPageRoute(builder: (Context) => ExpensePage(expense)
    ),
    );
  }
}

