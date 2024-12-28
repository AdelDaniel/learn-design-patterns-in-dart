// ignore_for_file: unnecessary_getters_setters

import 'dart:io';

abstract class State {
  void handler(Stateful context);
  @override
  String toString();
}

class StatusOn implements State {
  @override
  void handler(Stateful context) {
    print("  Handler of StatusOn is being called!");
    context.state = StatusOff();
  }

  @override
  String toString() => "on";
}

class StatusOff implements State {
  @override
  void handler(Stateful context) {
    print("  Handler of StatusOff is being called!");
    context.state = StatusOn();
  }

  @override
  String toString() => "off";
}

class Stateful {
  State _state;

  Stateful(this._state);

  State get state => _state;
  set state(State newState) => _state = newState;

  void touch() {
    print("  Touching the Stateful...");
    _state.handler(this);
  }
}

void main() {
  final offState = StatusOff();
  final onState = StatusOn();
  var lightSwitch = Stateful(offState);

// Normal Operation
  print("The light switch is ${lightSwitch.state}.");
  print("Toggling the light switch...");
  lightSwitch.touch();
  print("The light switch is ${lightSwitch.state}.");

  while (true) {
    print("Enter Operation: on - off");
    final String? op = stdin.readLineSync()?.toLowerCase().trim();

    print("Now: The light switch is ${lightSwitch.state}.");
    if (op?.contains('on') == true) {
      lightSwitch.state = onState;
      lightSwitch.touch();
    } else if (op?.contains('off') == true) {
      lightSwitch.state = offState;
      lightSwitch.touch();
    } else {
      print("Invalid operation. Please try again.");
      break;
    }

    print("Toggling the light switch...");
    print("The light switch is ${lightSwitch.state}.");
    print("\n");
  }
}
