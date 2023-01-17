class Service {}

class ExampleService implements Service {}

class AnotherExampleService implements Service {}

/// Without dependency injection
// the Client class contains a Service member variable initialized in the constructor.
// The client directly constructs and controls which service it uses,
// creating a hard-coded dependency.

class ClientWithoutDependencyInjection {
  late Service _service;

  ClientWithoutDependencyInjection() {
    // The dependency is hard-coded.
    _service = new ExampleService();
  }
}

/// Constructor injection
// most common form of dependency injection
// a class to request its dependencies through its constructor.
// This ensures the client is always in a valid state,
// since it cannot be instantiated without its necessary dependencies.

class ClientWithConstructorInjection {
  Service _service;

  // The dependency is injected through a constructor.
  ClientWithConstructorInjection(this._service);
}

/// Setter injection
// accepting dependencies through a setter method,
// rather than a constructor,
// clients can allow injectors to manipulate their dependencies at any time.
// This offers flexibility,
// but makes it difficult to ensure that all dependencies are injected and valid before the client is used.

class ClientWithSetterInjection {
  late Service _service;

  // The dependency is injected through a setter method.
  void setService(Service service) {
    _service = service;
  }
}

/// Interface injection
// dependencies are completely ignorant of their clients,
// yet still send and receive references to new clients.

// In this way, the dependencies become injectors.
// The key is that the injecting method is provided through an interface.

// An assembler is still needed to introduce the client and its dependencies.
// The assembler takes a reference to the client,
// casts it to the setter interface that sets that dependency,
// and passes it to that dependency object which in turn passes a reference to itself back to the client.

// For interface injection to have value,
// the dependency must do something in addition to simply passing back a reference to itself.
// This could be acting as a factory or sub-assembler to resolve other dependencies,
// thus abstracting some details from the main assembler.
// It could be reference-counting so that the dependency knows how many clients are using it.
// If the dependency maintains a collection of clients, it could later inject them all with a different instance of itself.

abstract class ServiceSetter {
  void setService(Service service);
}

class ClientWithInterfaceInjection implements ServiceSetter {
  late Service _service;

  @override
  void setService(Service service) {
    _service = service;
  }
}

class ServiceInjector {
  Set<ServiceSetter> _clients = {};

  void inject(ServiceSetter client) {
    _clients.add(client);
    client.setService(new ExampleService());
  }

  void switchAnotherExampleService() {
    for (var client in _clients) {
      client.setService(new AnotherExampleService());
    }
  }
}
