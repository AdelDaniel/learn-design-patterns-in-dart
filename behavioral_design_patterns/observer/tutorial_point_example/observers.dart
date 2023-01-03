import 'subject.dart';

/// Step 2
/// Create Observer class.
abstract class Observer {
  final Subject subject;
  Observer(this.subject);
  void update();
}

/// Step 3
/// Create concrete observer classes
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
