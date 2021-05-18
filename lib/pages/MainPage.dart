import 'package:flutter/material.dart';
import 'package:ewallet/pages/Home.dart';
import 'package:ewallet/pages/Spending.dart';
import 'package:ewallet/pages/Transaction.dart';
import 'package:ewallet/pages/Category.dart';
import 'package:ewallet/pages/Reports.dart';

class MainPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return Main();
  }
}
  class Main extends State<MainPage>{
    Widget build(BuildContext build){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu),
                tooltip: 'NavigationMenu',
                onPressed: null,
              ),
              title: Text('EWallet'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  tooltip: 'Search',
                  onPressed: null,
                ),
              ],
              bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,

                tabs: [
                  /*Tab(
                       child:Text( 'Home',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)
                      ),
                  ),*/
                  Tab(
                      child:Text('Spending',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                     ),
                    ),
                  Tab(
                      child:Text('Transaction',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                    ),
                  ),
                  Tab(

                      child:Text('Categories',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                      ),

                  ),
                  /*Tab(
                        child:Text('Reports',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)
                    ),
                   ),*/
                ],
              ),
            ),
            //body is the majority of the screen
            body:TabBarView(
              children: <Widget>[
                //new  HomePage(),
                new SpendingPage(),
                new TransactionPage(),
                new CategoryPage(),
                //new ReportPage()

              ],
            ),
          ),
        ),
      );
    }
  }


