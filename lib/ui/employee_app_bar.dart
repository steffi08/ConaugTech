import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ui/create_employee.dart';
import 'package:flutterapp/ui/employee_list_page.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 16,
                child: Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(border: Border.all()),
                        margin: EdgeInsets.all(25),
                        child: FlatButton(
                          child: Text(
                            'Employee List',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          color: Colors.white,
                          textColor: Colors.blueAccent,
                          onPressed: () {

                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                EmployeePage()), (Route<dynamic> route) => false);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.all()),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: FlatButton(
                          child: Text(
                            'Create Employee',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          color: Colors.white,
                          textColor: Colors.blueAccent,
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                CreateEmployee()), (Route<dynamic> route) => false);

                          },
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.menu,
        ));
  }
}
