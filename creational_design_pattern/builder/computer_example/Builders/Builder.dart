import '../Computer_parts/Keyboard.dart';
import '../Computer_parts/Monitor.dart';
import '../Computer_parts/MotherBoard/MotherBoard.dart';
import '../Computer_parts/Mouse.dart';
import '../Types/Computer.dart';

abstract class Builder {
  Computer get computer;

  MotherBoard buildMotherBoard();
  Keyboard buildKeyboard();
  Mouse buildMouse();
  Monitor buildMonitor();
}
