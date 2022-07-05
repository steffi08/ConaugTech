class Employee {
  String name;
  String emailId;
  String designation;

  Employee({this.name, this.emailId, this.designation});
  factory Employee.fromJson(dynamic json) {
    return Employee(name:json['name'], emailId:json['emailId'],designation:json['designation']);
  }
  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['name'] = name;
    m['emailId'] = emailId;
    m['designation']=designation;

    return m;
  }
}

class EmployeeList {
  List<Employee> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

