class Employee {
  Employee({required this.empCode, required this.empName});
  int empCode;
  String empName;
  @override
  String toString() => 'Employee(empCode: $empCode, empName: $empName)';
}

// client
abstract class ITarget {
  String GetDetails();
}

// adapter
class Adapter implements ITarget {
  IEmployeeDetails Data;
  Adapter(IEmployeeDetails data) : this.Data = data;

  String GetDetails() => Data.GetData();
}

// Service
abstract class IEmployeeDetails {
  String GetData();
}

// An employee class and an entity class
// The service interface implemented by 2 classes
// XML And Json
class XMLAdaptee implements IEmployeeDetails {
  String GetData() {
    List<Employee> employees = <Employee>[
      Employee(empCode: 1, empName: "Alex"),
      Employee(empCode: 2, empName: "Martin"),
      Employee(empCode: 3, empName: "Gloria"),
    ];
    // DO Some Stuff
    return employees.toString();
  }
}

// Now our JSON adaptee implements
class JSONAdaptee implements IEmployeeDetails {
  String GetData() {
    List<Employee> employees = <Employee>[
      Employee(empCode: 1, empName: "Alex"),
      Employee(empCode: 2, empName: "Martin"),
      Employee(empCode: 3, empName: "Gloria")
    ];
    return employees.toString();
  }
}

// our caller
void main() {
  IEmployeeDetails getXML = XMLAdaptee();
  IEmployeeDetails getJSON = JSONAdaptee();

  //To get XML data
  ITarget employeesDetailsFromXML = Adapter(getXML);
  print(employeesDetailsFromXML.GetDetails());

  //To get JSON data
  ITarget employeesDetailsFromJSON = Adapter(getJSON);
  print(employeesDetailsFromJSON.GetDetails());
}
