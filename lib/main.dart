import 'package:flutter/material.dart';
import 'package:flutterapp/ui/employee_list_page.dart';
import 'package:localstorage/localstorage.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'App Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new EmployeePage(),
    );
  }
}



