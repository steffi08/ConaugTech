import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/data/employee.dart';
import 'package:flutterapp/ui/employee_app_bar.dart';
import 'package:localstorage/localstorage.dart';

class EmployeePage extends StatefulWidget {
  EmployeePage({Key key}) : super(key: key);

  @override
  _EmployeePageState createState() => new _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final EmployeeList list = new EmployeeList();
  final LocalStorage storage = new LocalStorage('employee_app');
  bool initialized = false;
  TextEditingController controller = new TextEditingController();

  void initState() {
    List list1 = storage.getItem('employees');
    setState(() {
      list.items = list1.map((element) {
        element = new Employee.fromJson(element);
      }).toList();
    });
  }

  _removeItem(int index) {
    setState(() {
      list.items.removeAt(index);
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
          padding: EdgeInsets.all(10.0),
          constraints: BoxConstraints.expand(),
          child: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!initialized) {
                var items = storage.getItem('employees');

                if (items != null) {
                  list.items = List<Employee>.from(
                    (items as List).map(
                      (item) => Employee(
                          name: item['name'],
                          emailId: item['emailId'],
                          designation: item['designation']),
                    ),
                  );
                }
              }

              List<Widget> widgets = list.items.map((item) {
                return ListTile(
                  leading: Icon(Icons.contacts),
                  title: Text(item.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(item.emailId), Text(item.designation)],
                  ),
                  trailing: GestureDetector(
                      onTap: () {
                        _removeItem(list.items.indexOf(item));
                      },
                      child: Icon(
                        Icons.delete,
                      )),
                );
              }).toList();

              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: widgets,
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
