import 'package:flutter/material.dart';
import './product_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            //primarySwatch: Colors.white,
            primaryColor: Colors.black,
            accentColor: Colors.orange),
        home: Container(
            decoration: new BoxDecoration(color: Colors.black),
            child: Scaffold(
              appBar: AppBar(
                title: Text('StayApptive'),
              ),
              body: ProductManager(startingProduct: 'Food Tester'),
            )));
  }
}
