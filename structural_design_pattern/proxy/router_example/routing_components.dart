class ConnectionManager {
  connectTo(String ipAddress) => print("Connecting to $ipAddress");
  terminate() => print("Disconnecting... ");
}

class Firewall {
  bool isValidPacket(String packet) => !packet.contains("__BAD__");
}

class Route {
  String _url;
  String _ipAddress;

  Route(this._url, this._ipAddress);
  String getIpAddress() => _ipAddress;
  String getUrl() => _url;
}

class RoutingTable {
  List _routes;

  RoutingTable(this._routes);

  Route? mapUrlToIPAddress(String url) {
    for (var route in _routes) {
      if (route.getUrl() == url) {
        return route;
      }
    }
    return null;
  }
}
