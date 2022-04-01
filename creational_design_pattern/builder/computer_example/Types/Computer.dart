import '../Computer_parts/Keyboard.dart';
import '../Computer_parts/Monitor.dart';
import '../Computer_parts/MotherBoard/MotherBoard.dart';
import '../Computer_parts/Mouse.dart';

abstract class Computer {
  MotherBoard _motherBoard;
  Keyboard _keyboard;
  Mouse _mouse;
  Monitor _monitor;
  Computer({
    required MotherBoard motherBoard,
    required Keyboard keyboard,
    required Mouse mouse,
    required Monitor monitor,
  })  : _motherBoard = motherBoard,
        _keyboard = keyboard,
        _mouse = mouse,
        _monitor = monitor;

  bool turnOn();
  bool turnOff();

  String dashboard() => '';

  MotherBoard get motherBoard => _motherBoard;
  Keyboard get keyboard => _keyboard;
  Mouse get mouse => _mouse;
  Monitor get monitor => _monitor;
}
