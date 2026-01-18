// behavioral_design_patterns/visitor/computer_visitor_example.dart

// Step: 1
// Define an interface to represent element.
abstract interface class ComputerPart {
  void accept(ComputerPartVisitor computerPartVisitor);
}

/// Step: 2
/// Create concrete classes extending the above class.

/// Keyboard
class Keyboard implements ComputerPart {
  @override
  void accept(ComputerPartVisitor visitor) => visitor.visitKeyboard(this);
}

/// Monitor
class Monitor implements ComputerPart {
  @override
  void accept(ComputerPartVisitor visitor) => visitor.visitMonitor(this);
}

/// Mouse
class Mouse implements ComputerPart {
  @override
  void accept(ComputerPartVisitor visitor) => visitor.visitMouse(this);
}

/// Computer
class Computer implements ComputerPart {
  late List<ComputerPart> parts = [Mouse(), Keyboard(), Monitor()];

  @override
  void accept(ComputerPartVisitor visitor) {
    for (int i = 0; i < parts.length; i++) {
      parts[i].accept(visitor);
    }
    visitor.visitComputer(this);
  }
}

/// Step: 3
/// Define an interface to represent visitor.

/// ComputerPartVisitor
abstract interface class ComputerPartVisitor {
  void visitComputer(Computer computer);
  void visitMouse(Mouse mouse);
  void visitKeyboard(Keyboard keyboard);
  void visitMonitor(Monitor monitor);
}

/// Step: 4
/// Create concrete visitor implementing the above class.

/// ComputerPartDisplayVisitor
class ComputerPartDisplayVisitor implements ComputerPartVisitor {
  @override
  void visitComputer(Computer computer) => print("Displaying Computer.");

  @override
  void visitMouse(Mouse mouse) => print("Displaying Mouse.");

  @override
  void visitKeyboard(Keyboard keyboard) => print("Displaying Keyboard.");

  @override
  void visitMonitor(Monitor monitor) => print("Displaying Monitor.");
}

/// Example - Usage of Visitor Pattern
/// Use the ComputerPartDisplayVisitor to display parts of Computer.

/// VisitorPatternDemo
void main() {
  ComputerPart computer = Computer();
  computer.accept(ComputerPartDisplayVisitor());
}

/// Output
// Verify the output.

// Displaying Mouse.
// Displaying Keyboard.
// Displaying Monitor.
// Displaying Computer.
