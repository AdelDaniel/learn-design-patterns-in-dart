import '../Computer_parts/CoolingSystem.dart';
import '../Computer_parts/Keyboard.dart';
import '../Computer_parts/Monitor.dart';
import '../Computer_parts/MotherBoard/MotherBoard.dart';
import '../Computer_parts/Mouse.dart';
import 'Computer.dart';
import 'ICoolingSystem.dart';

class ComputerCS extends Computer implements ICoolingSystem {
  CoolingSystem _coolingSystem;

  ComputerCS({
    required CoolingSystem coolingSystem,
    required Keyboard keyboard,
    required Monitor monitor,
    required MotherBoard motherBoard,
    required Mouse mouse,
  })  : _coolingSystem = coolingSystem,
        super(
          keyboard: keyboard,
          monitor: monitor,
          motherBoard: motherBoard,
          mouse: mouse,
        );

  @override
  bool coolDown(int temp) {
    // do something and then
    return true;
  }

  @override
  bool turnOff() {
    // Do something
    return true;
  }

  @override
  bool turnOn() {
    // do something to cool down to $temp
    return true;
  }

  CoolingSystem get coolingSystem => _coolingSystem;
}
