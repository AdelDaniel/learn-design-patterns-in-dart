import 'dart:io';

import 'observers.dart';
import 'subject.dart';

/// Step 4
/// Use Subject and concrete observer objects.
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
