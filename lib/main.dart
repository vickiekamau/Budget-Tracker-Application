import 'package:flutter/material.dart';
import 'package:ewallet/pages/MainPage.dart';

void main(){
  runApp(MyApp()
      //home: MyApp(),
  );
}
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallet',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MainPage()
    );

  }
}