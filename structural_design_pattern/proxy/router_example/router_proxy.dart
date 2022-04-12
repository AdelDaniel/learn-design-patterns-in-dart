import 'router.dart';
import 'clients.dart';

class RouterProxy implements RouterInterface {
  RouterInterface _router;
  Client _app;
  List<Client> _accessControlList;

  RouterProxy(this._router, this._accessControlList, this._app);

  bool resolve(String $url) {
    if (isAllowedClient()) {
      return _router.resolve($url);
    } else {
      print("Hi:${_app.name}: This Client can not use the router");
    }
    return false;
  }

  stream() {
    if (isAllowedClient()) {
      _router.stream();
    } else {
      print("Hi:${_app.name}: This Client can not use the router");
    }
  }

  bool isAllowedClient() =>
      _accessControlList.any((Client c) => c.name == _app.name);
}
