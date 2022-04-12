import 'routing_components.dart';

abstract class RouterInterface {
  bool resolve(String url);
  void stream();
}

class Router implements RouterInterface {
  ConnectionManager _connectionManager;
  RoutingTable _table;
  Firewall _firewall;

  Router(this._connectionManager, this._table, this._firewall);

  @override
  bool resolve(String _url) {
    Route? _route = _table.mapUrlToIPAddress(_url);
    if (_route != null) {
      _connect(_route.getIpAddress());
    } else {
      print("Route was not found.");
      return false;
    }
    return true;
  }

  @override
  void stream() {
    List<String> _packets = [
      'Package one is clean',
      'Package two is clean',
      'Package three is __BAD__',
      'Package four is __BAD__',
    ];

    for (String packet in _packets) {
      if (_firewall.isValidPacket(packet)) {
        print("$packet.");
      } else {
        print("Dropping a packet.");
      }
    }

    _terminate();
  }

  void _terminate() => _connectionManager.terminate();
  void _connect(String _ipAddress) => _connectionManager.connectTo(_ipAddress);
}
