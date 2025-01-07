// Employee class
// Salary Example

/// Let’s say we have a collection of employees in a company,
/// and we want to iterate over the employees to calculate their total salary.
/// However, the employees are stored in different types of collections (arrays, lists, etc.),
/// and we want to iterate over them without exposing the underlying collection types.
library;

// Employee class
class Employee {
  final String _name;
  final double _salary;

  Employee(this._name, this._salary);

  double getSalary() => _salary;
  String getName() => _name;
}

/// Iterator interface
abstract interface class Iterator<T> {
  bool hasNext();
  T next();
}

/// Aggregate interface
abstract interface class Aggregate<T> {
  Iterator<T> createIterator();
}

/// Concrete Iterator
class EmployeeIterator implements Iterator<Employee> {
  int _currentIndex = 0;
  final List<Employee> _employees;

  EmployeeIterator(List<Employee> employees) : _employees = employees;

  @override
  bool hasNext() {
    return _currentIndex < _employees.length;
  }

  @override
  Employee next() {
    if (!hasNext()) {
      throw Exception("No such element");
    }
    return _employees[_currentIndex++];
  }
}

// Concrete Aggregate
class Company implements Aggregate<Employee> {
  final List<Employee> _employees;

  Company(List<Employee> employees) : _employees = employees;

  @override
  Iterator<Employee> createIterator() {
    return EmployeeIterator(_employees);
  }
}

void main() {
  List<Employee> employees = [];
  employees.add(Employee("Alice", 50000));
  employees.add(Employee("Bob", 60000));
  employees.add(Employee("Charlie", 70000));

  Company company = Company(employees);
  Iterator<Employee> iterator = company.createIterator();

  double totalSalary = 0;
  while (iterator.hasNext()) {
    totalSalary += iterator.next().getSalary();
  }

  print("Total salary: $totalSalary");
}

/// Total salary: 180000.0
