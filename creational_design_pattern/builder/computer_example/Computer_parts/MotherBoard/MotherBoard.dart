export 'main_parts.dart';
export 'sockets_types.dart';

import 'main_parts.dart';

class MotherBoard {
  CPU _cpu;
  RAM _ram;
  GPU _gpu;
  Sockets _sockets;
  NetworkCard _networkCard;
  Disk _disk;

  MotherBoard(
      {required CPU cpu,
      required RAM ram,
      required GPU gpu,
      required Sockets sockets,
      required NetworkCard networkCard,
      required Disk disk})
      : _cpu = cpu,
        _ram = ram,
        _gpu = gpu,
        _sockets = sockets,
        _networkCard = networkCard,
        _disk = disk;

  CPU get cpu => _cpu;
  RAM get ram => _ram;
  GPU get gpu => _gpu;
  Sockets get sockets => _sockets;
  NetworkCard get networkCard => _networkCard;
  Disk get disk => _disk;
}
