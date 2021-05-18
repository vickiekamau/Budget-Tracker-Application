import 'dart:io';
import 'package:commons/commons.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:ewallet/Model/Budget.dart';
import 'package:ewallet/Model/Expense.dart';
import 'package:ewallet/Model/Categoty.dart';


class DatabaseHelper{
  static DatabaseHelper _databaseHelper;//singleton DatabaseHelper object the singleton means the instance will be initialised only once in the application till the application shuts down

  //create a database and provide it with a getter where we will instantiate the database
  static Database _database;//singleton database
  String budTable = 'budget';
  String budId = 'id';
  String budAmount = 'amount';
  String  budNote = 'note';
  String budDate = 'date';
  String expTable = 'expenses';
  String expId = 'id';
  String expCategory = 'category';
  String expAmount = 'amount';
  String expNote = 'note';
  String expDate = 'date';
  String catTable = 'category';
  String catId = 'id';
  String catName = 'category_name';
  String catDate = 'date';

  DatabaseHelper._createInstance();//named constructor to create instance of the database helper

    factory DatabaseHelper(){//when you use factory keyword the constructor will allow you to return some value
       if( _databaseHelper == null){//create instance of the database helper only if it is null
         _databaseHelper = DatabaseHelper._createInstance();//initialize our object it will be executed only once in our application
         }
        return _databaseHelper;
  }
   Future<Database> get database async{
     if( _database == null){//if database is null we instantiate the database
       _database = await initDB();
     }
     return _database;
   }
   //if no object assigned to the database we use initDB() function to create the database/ in this function we create the path of storing the database and create desired tables
   Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory(); //since the function return a future object we use await keyword
    //get a location using get database path
    String path = directory.path + 'wallet.db';
    var walletDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return walletDb;
   }
  void _createDb(Database db, int newVersion) async {
      await db.execute('DROP TABLE IF EXISTS $budTable');
    await db.execute('CREATE TABLE $budTable($budId INTEGER PRIMARY KEY AUTOINCREMENT, $budAmount INTEGER, $budNote TEXT, $budDate STRING)');
    await db.execute('CREATE TABLE $expTable($expId INTEGER PRIMARY KEY AUTOINCREMENT, $expCategory TEXT, $expAmount INTEGER, $expNote TEXT, $expDate INTEGER)');
    await db.execute('CREATE TABLE $catTable($catId INTEGER PRIMARY KEY AUTOINCREMENT, $catName TEXT, $catDate TEXT)');
      }

      Future<List<Map<String,dynamic>>> getBudgetMapList() async{// future of list of map, when we query some data from the database you get a list of map in return
      Database db = await this.database;
      var select = await db.query(budTable,orderBy: '$budId ASC');
      return select;
    }
    //insert operation
  Future<int> insertBudget(Budget budget) async{
      Database db = await this.database;

      var insert = await db.insert(budTable,budget.toMap());
      return insert;
  }
  //update operation: Update a budget object and save it to database
  Future<int> updateBudget(Budget budget) async{
      Database db = await this.database;
      var update = await db.update(budTable,budget.toMap(), where: '$budId = ?', whereArgs: [budget.id]);
      return update;
  }
  Future<int> deleteBudget(int id) async{
      Database db = await this.database;
      var delete = await db.rawDelete('DELETE FROM $budTable WHERE $budId = $id');
      return delete;
  }
  // get the number of objects in the database
  Future<int> getBudgetCount() async{
      Database db = await this.database;
      List<Map<String,dynamic>> x  = await db.rawQuery('SELECT COUNT(*) FROM $budTable');
      int count = Sqflite.firstIntValue(x);
      return count;
  }
  //get the Map List[List<Map>] and convert it to Budget List [List<Budget>]
  Future<List<Budget>> getBudgetList() async{
      var budgetMapList = await getBudgetMapList();
      int count = budgetMapList.length;

      List<Budget> budgetList = List<Budget>();
      //for loop to create a Budget List from a Map List
    for(int i = 0; i<count; i++){
      budgetList.add(Budget.fromMapObject(budgetMapList[i]));
    }
    return budgetList;
  }
  Future<int> getBudgetAmount()async{
    Database db = await this.database;
    int amount = Sqflite.firstIntValue(await db.rawQuery('SELECT sum($budAmount) FROM $budTable where strftime("%m",$budDate)= "06"'));
    return amount;
  }

                    //Expense Table--->
  Future<List<Map<String,dynamic>>> getExpenseMapList() async{// future of list of map, when we query some data from the database you get a list of map in return
    Database db = await this.database;
    var select = await db.query(expTable,orderBy: '$expDate ASC');
    return select;
  }
  //insert operation
  Future<int> insertExpense(Expense expense) async{
    Database db = await this.database;

    var insert = await db.insert(expTable,expense.toMap());
    return insert;
  }
  //update operation: Update a budget object and save it to database
  Future<int> updateExpense(Expense expense) async{
    Database db = await this.database;
    var update = await db.update(expTable,expense.toMap(), where: '$expId = ?', whereArgs: [expense.id]);
    return update;
  }
  Future<int> deleteExpense(int id) async{
    Database db = await this.database;
    var delete = await db.rawDelete('DELETE FROM $expTable WHERE $expId = $id');
    return delete;
  }
  // get the number of objects in the database
  Future<int> getExpenseCount() async{
    Database db = await this.database;
    List<Map<String,dynamic>> x  = await db.rawQuery('SELECT COUNT(*) FROM $expTable');
    int count = Sqflite.firstIntValue(x);
    return count;
  }
  Future<int> getTotalExpense()async{
    Database db = await this.database;
    List<Map<String,dynamic>> totalExpense = await db.rawQuery('SELECT sum($expAmount) as Total FROM $expTable');
    int amount = Sqflite.firstIntValue(totalExpense);
    return amount;
  }
  //get the Map List[List<Map>] and convert it to Budget List [List<Budget>]
  Future<List<Expense>> getExpenseList() async{
    var expenseMapList = await getExpenseMapList();
    int count = expenseMapList.length;

    List<Expense> expenseList = List<Expense>();
    //for loop to create a Budget List from a Map List
    for(int i = 0; i<count; i++){
      expenseList.add(Expense.fromMapObject(expenseMapList[i]));
    }
    return expenseList;
  }

                //Category Table--->
  Future<List<Map<String,dynamic>>> getCategoryMapList() async{// future of list of map, when we query some data from the database you get a list of map in return
    Database db = await this.database;
    var select = await db.query(catTable,orderBy: '$catDate ASC');
    return select;
     }
  //insert operation
  Future<int> insertCategory(Category category) async{
    Database db = await this.database;

    var insert = await db.insert(catTable,category.toMap());
    return insert;
  }
  //update operation: Update a budget object and save it to database
  Future<int> updateCategory(Category category) async{
    Database db = await this.database;
    var update = await db.update(catTable,category.toMap(), where: '$catId = ?', whereArgs: [category.id]);
    return update;
  }
  Future<int> deleteCategory(int id) async{
    Database db = await this.database;
    var delete = await db.rawDelete('DELETE FROM $catTable WHERE $catId = $id');
    return delete;
  }
  // get the number of objects in the database
  Future<int> getCategoryCount() async{
    Database db = await this.database;
    List<Map<String,dynamic>> x  = await db.rawQuery('SELECT COUNT(*) FROM $catTable');
    int count = Sqflite.firstIntValue(x);
    return count;
  }
  //get the Map List[List<Map>] and convert it to Budget List [List<Budget>]
  Future<List<Category>> getCategoryList() async{
    var categoryMapList = await getCategoryMapList();
    int count = categoryMapList.length;

    List<Category> categoryList = List<Category>();
    //for loop to create a Budget List from a Map List
    for(int i = 0; i<count; i++){
      categoryList.add(Category.fromMapObject(categoryMapList[i]));
       }
    return categoryList;
   }
}