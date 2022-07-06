import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ui/employee_app_bar.dart';

import 'create_employee.dart';

class EmployeePage extends StatefulWidget {
  EmployeePage({Key? key}) : super(key: key);

  @override
  _EmployeePageState createState() => new _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference employees= FirebaseFirestore.instance.collection('employees');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Conaug App'),
        leading: AppBarWidget(),
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          constraints: BoxConstraints.expand(),
          child: StreamBuilder(
            stream:
            employees.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: snapshot.data!.docs.map((employee) {

                        return ListTile(
                          leading: Icon(Icons.contacts),
                          title: Text(employee['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(employee['emailId']),
                              Text(employee['designation'])
                            ],
                          ),
                          trailing:Container(
                            width: 50,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      CreateEmployee(employee:employee)), (Route<dynamic> route) => false);
                                },
                                child: Icon(
                                  Icons.edit,
                                )),
                            GestureDetector(
                                onTap: () {
                                  employee.reference.delete();
                                },
                                child: Icon(
                                  Icons.delete,
                                ))
                          ],)),
                        );
                      }).toList(),
                      itemExtent: 50.0,
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
