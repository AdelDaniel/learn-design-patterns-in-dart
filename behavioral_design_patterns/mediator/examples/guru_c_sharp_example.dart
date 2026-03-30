// behavioral_design_patterns/mediator/examples/guru_c_sharp_example.dart

/// The Mediator interface declares a method used by components to notify the
/// mediator about various events. The Mediator may react to these events and
/// pass the execution to other components.
abstract interface class Mediator {
  void notify(Object sender, String event);
}

// The Base Component provides the basic functionality of storing a
// mediator's instance inside component objects.
abstract class BaseComponent {
  Mediator? _mediator;

  BaseComponent([this._mediator]);

  void setMediator(Mediator mediator) => _mediator = mediator;
}

/// Concrete Components implement various functionality. They don't depend on
/// other components. They also don't depend on any concrete mediator classes.
class Component1 extends BaseComponent {
  void doA() {
    print("Component 1 does A.");
    _mediator?.notify(this, "A");
  }

  void doB() {
    print("Component 1 does B.");
    _mediator?.notify(this, "B");
  }
}

class Component2 extends BaseComponent {
  void doC() {
    print("Component 2 does C.");
    _mediator?.notify(this, "C");
  }

  void doD() {
    print("Component 2 does D.");
    _mediator?.notify(this, "D");
  }
}

/// Concrete Mediators implement cooperative behavior by coordinating several components.
class ConcreteMediator implements Mediator {
  final Component1 _component1;
  final Component2 _component2;

  ConcreteMediator(this._component1, this._component2) {
    _component1.setMediator(this);
    _component2.setMediator(this);
  }

  @override
  void notify(Object sender, String event) {
    if (event == "A") {
      print("Mediator reacts on A and triggers following operations:");
      _component2.doC();
    }
    if (event == "D") {
      print("Mediator reacts on D and triggers following operations:");
      _component1.doB();
      _component2.doC();
    }
  }
}

void main() {
  // The client code.
  final component1 = Component1();
  final component2 = Component2();
  ConcreteMediator(component1, component2);

  print("Client triggers operation A.");
  component1.doA();

  print("");

  print("Client triggers operation D.");
  component2.doD();
}
