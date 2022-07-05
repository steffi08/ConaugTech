import 'package:flutter/material.dart';
import 'package:flutterapp/data/employee.dart';
import 'package:flutterapp/ui/employee_app_bar.dart';
import 'package:flutterapp/ui/employee_list_page.dart';
import 'package:localstorage/localstorage.dart';

class CreateEmployee extends StatefulWidget {
  CreateEmployee({Key key}) : super(key: key);

  @override
  _CreateEmployeeState createState() => new _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  final EmployeeList list = new EmployeeList();
  final LocalStorage storage = new LocalStorage('employee_app');
  bool initialized = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController designationController = new TextEditingController();
  void initState() {
    setState(() {

     List list1= storage.getItem('employees');
     list.items=list1.map((element) {return new Employee.fromJson(element);}).toList()??[];
    });
  }


  _addItem(String name, String emailId, String designation) {
    setState(() {
      final item =
          new Employee(name: name, emailId: emailId, designation: designation);
      list.items.add(item);
      _saveToStorage();
    });
  }

  _saveToStorage() {
    storage.setItem('employees', list.toJSONEncodable());
  }


  @override
  Widget build(BuildContext context) {
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
            Text('Create Employee'),
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
                      padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: _save,
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
       if (_formKey.currentState.validate()) {
    _addItem(nameController.value.text, emailController.value.text,
        designationController.value.text);
    nameController.clear();
    emailController.clear();
    designationController.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => EmployeePage()),
        (Route<dynamic> route) => false);
  }}
}
