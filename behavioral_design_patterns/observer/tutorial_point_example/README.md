# Tutorial Point Example

src: https://www.tutorialspoint.com/design_pattern/observer_pattern.htm

<img src = "../assets/observer_pattern_uml_diagram.jpg">

- Subject, Observer and Client.
- Subject is an object having methods to attach and detach observers to a client object.
- We have created an abstract class Observer and a concrete class Subject that is extending class Observer.

### Step 1

### Create Subject class.

```dart

import 'dart:io';
class Subject {
  List<Observer> _observers = [];
  late int _state;

  int get getState => _state;

  void setState(int state) {
    _state = state;
    notifyAllObservers();
  }

  void attach(Observer observer) {
    _observers.add(observer);
  }

  void notifyAllObservers() {
    for (Observer observer in _observers) {
      observer.update();
    }
  }
}
```

### Step 2

### Create Observer class.

```dart
abstract class Observer {
  final Subject subject;
  Observer(this.subject);
  void update();
}
```

### Step 3

### Create concrete observer classes

```dart

class BinaryObserver extends Observer {
  BinaryObserver(super.subject) {
    subject.attach(this);
  }

  @override
  void update() {
    int state = subject.getState;
    print("Binary String:  ${state.toRadixString(2)}");
  }
}

class OctalObserver extends Observer {
  OctalObserver(super.subject) {
    subject.attach(this);
  }

  @override
  void update() {
    int state = subject.getState;
    print("Octal String:  ${state.toRadixString(8)}");
  }
}

class HexObserver extends Observer {
  HexObserver(super.subject) {
    subject.attach(this);
  }

  @override
  void update() {
    int state = subject.getState;
    print("Hex String: ${state.toRadixString(16)}");
  }
}
```

### Step 4

### Use Subject and concrete observer objects.

```dart
void main() {
  Subject subject = Subject();
  HexObserver(subject);
  OctalObserver(subject);
  BinaryObserver(subject);
  int number = 0;
  while (number >= 0) {
    stdout.write("Enter number >=0 or <0 to exit: ");
    number = int.tryParse(stdin.readLineSync() ?? "-1") ?? -1;
    subject.setState(number);
  }

  print("First state change: 15");
  subject.setState(15);
  print("Second state change: 10");
  subject.setState(10);
}

```
