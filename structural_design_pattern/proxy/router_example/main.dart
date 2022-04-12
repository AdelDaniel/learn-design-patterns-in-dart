import 'clients.dart';
import 'router.dart';
import 'router_proxy.dart';
import 'routing_components.dart';

void main(List<String> args) {
  List<Client> allowedRouterUsers = [Manager()];
  List<Route> routes = [
    Route('http://www.google.com', '152.233.22.1'),
    Route('http://www.abc.com', '93.23.2.232'),
    Route('http://www.xyz.com', '18.87.198.1'),
  ];

  RoutingTable table = RoutingTable(routes);
  Firewall firewall = Firewall();
  ConnectionManager connectionManager = ConnectionManager();

  print('----------------------------------');
  print('----------testing without proxy----------');
  Router router = Router(connectionManager, table, firewall);
  test(router);

  print('\n----------------------------------');
  print('----------proxy testing with allowed client----------');
  RouterInterface proxyRouterAllowed =
      RouterProxy(router, allowedRouterUsers, Manager());
  test(proxyRouterAllowed);

  print('\n----------------------------------');
  print('----------proxy testing with not allowed client----------');
  RouterInterface proxyRouterNotAllowed =
      RouterProxy(router, allowedRouterUsers, NormalClient());
  test(proxyRouterNotAllowed);
}

void test(RouterInterface router) {
  if (router.resolve('http://www.google.com')) {
    print("valid Resolve");
    router.stream();
    print("Stream Done!");
  } else {
    print("invalid Resolve!");
  }
  print("\n -------------another link-------------");
  if (router.resolve('http://www.not avalable.com')) {
    print("valid Resolve");
    router.stream();
    print("Stream Done!");
  } else {
    print("invalid Resolve!");
  }
}
