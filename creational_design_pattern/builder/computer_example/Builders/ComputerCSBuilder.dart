import '../Computer_parts/CoolingSystem.dart';
import '../Computer_parts/Keyboard.dart';
import '../Computer_parts/Monitor.dart';
import '../Computer_parts/MotherBoard/MotherBoard.dart';
import '../Computer_parts/Mouse.dart';
import '../Types/Computer.dart';
import '../Types/ComputerCS.dart';
import '../Computer_parts/UPS.dart';
import 'Builder.dart';

class ComputerCSBuilder extends Builder {
  @override
  MotherBoard buildMotherBoard() {
    CPU cpu = CPU(2.8);
    RAM ram = RAM(16);
    GPU gpu = GPU(2);
    Sockets sockets =
        Sockets([USB('2'), USB('3'), CType(true), CType(true), CType(true)]);
    NetworkCard networkCard = NetworkCard(5);
    Disk disk = Disk('SSD');

    return MotherBoard(
        cpu: cpu,
        ram: ram,
        gpu: gpu,
        sockets: sockets,
        networkCard: networkCard,
        disk: disk);
  }

  @override
  Keyboard buildKeyboard() => Keyboard(true);
  @override
  Mouse buildMouse() => Mouse(false);
  @override
  Monitor buildMonitor() => Monitor('1920 FHD');

  CoolingSystem buildCoolingSystem() => CoolingSystem(5);
  UPS buildUPS() => UPS(96);

  @override
  Computer get computer {
    Computer computer = ComputerCS(
      keyboard: buildKeyboard(),
      monitor: buildMonitor(),
      motherBoard: buildMotherBoard(),
      coolingSystem: buildCoolingSystem(),
      mouse: buildMouse(),
    );
    return computer;
  }
}
