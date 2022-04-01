class CPU {
  double _speed;
  CPU(double speed) : _speed = speed;
  double get speed => _speed;
}

class Disk {
  String _type;
  Disk(String type) : _type = type;
  String get type => _type;
}

class GPU {
  int _size;
  GPU(int size) : _size = size;
  int get size => _size;
}

class NetworkCard {
  int _category;
  NetworkCard(int category) : _category = category;
  int get category => _category;
}

class RAM {
  int _size;
  RAM(int size) : _size = size;
  int get size => _size;
}

class Sockets {
  List _sockets;
  Sockets(List sockets) : _sockets = sockets;
  List get sockets => _sockets;
}
