class Client {
  String name;
  Client(this.name);
}

class Manager extends Client {
  Manager({String name = 'manager'}) : super(name);
}

class NormalClient extends Client {
  NormalClient([String name = 'Normal Client']) : super(name);
}
