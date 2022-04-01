import '../Computer_parts/CoolingSystem.dart';
import '../Computer_parts/Keyboard.dart';
import '../Computer_parts/Monitor.dart';
import '../Computer_parts/MotherBoard/MotherBoard.dart';
import '../Computer_parts/Mouse.dart';
import '../Computer_parts/UPS.dart';
import 'Computer.dart';
import 'ICoolingSystem.dart';
import 'IPower.dart';

class ComputerXL extends Computer implements ICoolingSystem, IPower {
  CoolingSystem _coolingSystem;
  UPS _ups;

  ComputerXL(
      {required CoolingSystem coolingSystem,
      required UPS ups,
      required Keyboard keyboard,
      required Monitor monitor,
      required MotherBoard motherBoard,
      required Mouse mouse})
      : _coolingSystem = coolingSystem,
        _ups = ups,
        super(
          keyboard: keyboard,
          monitor: monitor,
          motherBoard: motherBoard,
          mouse: mouse,
        );

  @override
  bool turnOn() {
    // do something and then
    return true;
  }

  @override
  bool turnOff() {
    // Do something
    return true;
  }

  @override
  bool coolDown(int temp) {
    // do something to cool down to temp
    return true;
  }

  @override
  bool backupPower() {
    // do something to resume after a power loss
    return true;
  }

  CoolingSystem get coolingSystem => _coolingSystem;
  UPS get ups => _ups;
}
