import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ui/employee_app_bar.dart';
import 'package:flutterapp/ui/employee_list_page.dart';

class CreateEmployee extends StatefulWidget {
  CreateEmployee({Key? key, this.employee}) : super(key: key);
   final QueryDocumentSnapshot? employee;
  @override
  _CreateEmployeeState createState() => new _CreateEmployeeState(employee: employee);
}

class _CreateEmployeeState extends State<CreateEmployee> {
  final QueryDocumentSnapshot? employee;
  _CreateEmployeeState({this.employee});
  CollectionReference employees= FirebaseFirestore.instance.collection('employees');
  final _formKey = GlobalKey<FormState>();
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? designationController;

  void initState() {
    super.initState();
    nameController = TextEditingController(text:employee!=null?employee!['name']:'');
    emailController = TextEditingController(text:employee!=null?employee!['emailId']:'');
    designationController = TextEditingController(text:employee!=null?employee!['designation']:'');
  }

  _addEmployee(String name, String emailId, String designation) {
      employees.add({
        'name':name,
        'emailId':emailId,
        'designation':designation
      });
  }

  _updateEmployee(String name, String emailId, String designation) {
    employee!.reference.update({
      'name':name,
      'emailId':emailId,
      'designation':designation
    });
  }



  @override
  Widget build(BuildContext context){

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Conaug App'),
        leading: AppBarWidget(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text('${employee != null?'Edit Employee':'Create Employee'}'),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter employee name',
                      labelText: 'Name',

                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a email Id',
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: designationController,
                    decoration: const InputDecoration(
                      hintText: 'Enter employee designation',
                      labelText: 'Designation',
                    ),
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 100.0, top: 40.0),
                      child: new RaisedButton(
                        child:  Text('${employee != null?'Edit Employee':'Create Employee'}'),
                        onPressed: employee != null?_update:_save,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save() {
       if (_formKey.currentState!.validate()) {
         _addEmployee(nameController!.value.text, emailController!.value.text,
        designationController!.value.text);
    nameController!.clear();
    emailController!.clear();
    designationController!.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => EmployeePage()),
        (Route<dynamic> route) => false);
  }}
  void _update() {
    if (_formKey.currentState!.validate()) {
      _updateEmployee(nameController!.value.text, emailController!.value.text,
          designationController!.value.text);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => EmployeePage()),
              (Route<dynamic> route) => false);
    }}
}
