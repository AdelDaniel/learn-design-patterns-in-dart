import 'dart:developer';

/// The definition is a bit confusing at first but let’s step through it.
/// In analogy to our problem above remote control is the client and stereo, lights etc. are the receivers.
/// In command pattern there is a Command object that encapsulates a request by binding together a set of actions on a specific receiver.\
/// It does so by exposing just one method execute() that causes some actions to be invoked on the receiver.
///
/// src: https://www.geeksforgeeks.org/command-pattern/

/// implementation of Command Pattern using
/// a remote control example.

/// An interface for command
abstract interface class Command {
  void execute();
}

/// Light class (Receiver) and its corresponding command
///
/// classes
class Light {
  void on() => log("Light is on");
  void off() => log("Light is off");
}

class LightOnCommand implements Command {
  Light light;

  /// The constructor is passed the light it
  /// is going to control.
  LightOnCommand(this.light);

  void execute() => light.on();
}

class LightOffCommand implements Command {
  Light light;

  /// The constructor is passed the light it
  /// is going to control.
  LightOffCommand(this.light);
  void execute() => light.off();
}

/// Stereo (Receiver) and its command classes
class Stereo {
  void on() => log("Stereo is on");

  void off() => log("Stereo is off");

  void setCD() => log("Stereo is set " + "for CD input");

  void setDVD() => log("Stereo is set" + " for DVD input");

  void setRadio() => log("Stereo is set" + " for Radio");

  /// code to set the volume
  void setVolume(int volume) => log("set Stereo volume to: $volume");
}

class StereoOffCommand implements Command {
  Stereo stereo;
  StereoOffCommand(this.stereo);
  void execute() => stereo.off();
}

class StereoOnWithCDCommand implements Command {
  Stereo stereo;
  StereoOnWithCDCommand(this.stereo);
  void execute() {
    stereo.on();
    stereo.setCD();
    stereo.setVolume(11);
  }
}

/// Invoker (Sender) A Simple remote control with one button
class SimpleRemoteControl {
  /// only one button
  Command? slot;

  SimpleRemoteControl();

  void setCommand(Command command) {
    // set the command the remote will
    // execute
    slot = command;
  }

  void buttonWasPressed() {
    slot?.execute();
  }
}

/// Driver class

void main() {
  /// Sender (Invoker)
  SimpleRemoteControl remote = SimpleRemoteControl();

  /// Receivers
  Light light = Light();
  Stereo stereo = Stereo();

  /// Commands
  LightOnCommand lightOnCommand = LightOnCommand(light);
  StereoOnWithCDCommand stereoOnWithCDCommand = StereoOnWithCDCommand(stereo);
  StereoOffCommand stereoOffCommand = StereoOffCommand(stereo);

  /// we can change command dynamically
  remote.setCommand(lightOnCommand);
  remote.buttonWasPressed();
  remote.setCommand(stereoOnWithCDCommand);
  remote.buttonWasPressed();
  remote.setCommand(stereoOffCommand);
  remote.buttonWasPressed();
}

/// Notice that the remote control doesn’t know anything about turning on the stereo.
/// That information is contained in a separate command object.
/// This reduces the coupling between them.

/// Advantages:
/// Makes our code extensible as we can add new commands without changing existing code.
/// Reduces coupling between the invoker and receiver of a command.
///
/// Disadvantages:
/// Increase in the number of classes for each individual command
