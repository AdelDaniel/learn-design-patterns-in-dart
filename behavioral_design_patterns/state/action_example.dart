import 'dart:io';

/// Step 1: Create an interface.
abstract interface class State {
  void doAction(Context context);
}

/// Step 2: Create concrete classes implementing the same interface.
class StartState implements State {
  @override
  void doAction(Context context) {
    print("Player is in start state");
    context.setState(this);
  }

  @override
  String toString() => "Start State";
}

class StopState implements State {
  @override
  void doAction(Context context) {
    print("Player is in stop state");
    context.setState(this);
  }

  @override
  String toString() => "Stop State";
}

/// Step 3: Create Context Class.
class Context {
  late State _state;

  Context() : _state = StartState();

  void setState(State state) => _state = state;

  State get state => _state;

  void doAction() {
    _state.doAction(this);
  }
}

/// Step 4: Use the Context to see change in behavior when State changes.

void main() {
  Context context = Context();

  final StartState startState = StartState();
  startState.doAction(context);

  print(context.state.toString());

  final StopState stopState = StopState();
  stopState.doAction(context);

  print(context.state.toString());

  /// Do While

  while (true) {
    print("\n");
    print("Enter Operation: start - stop");
    final String? op = stdin.readLineSync()?.toLowerCase().trim();

    print("Now: The player is ${context.state}.");
    if (op?.contains('start') == true) {
      startState.doAction(context);
    } else if (op?.contains('stop') == true) {
      stopState.doAction(context);
    } else {
      print("Invalid operation. Please try again.");
      break;
    }

    print("Done: The player is ${context.state}.");
    print("\n");
  }
}

/// Step 5: Verify the output.

// Player is in start state
// Start State
// Player is in stop state
// Stop State
