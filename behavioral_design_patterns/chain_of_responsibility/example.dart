// Chain of Responsibility is behavioral design pattern
// that allows passing request along the chain of potential handlers
// until one of them handles request.

// The pattern allows multiple objects to handle the request
// without coupling sender class to the concrete classes of the receivers.
// The chain can be composed dynamically at runtime
// with any handler that follows a standard handler interface.

// Usage examples:
// it’s only relevant when code operates with chains of objects.

// One of the most popular use cases for the pattern is bubbling events to the parent components in GUI classes.
// Another notable use case is sequential access filters.

// Identification:
// The pattern is recognizable by behavioral methods of one group of objects
// that indirectly call the same methods in other objects,
// while all the objects follow the common interface.

// Filtering access
// This example shows how a request containing user data passes a sequential chain of handlers
// that perform various things such as authentification, authorization, and validation.

// This example is a bit different from the canonical version of the pattern given by various authors.
// Most of the pattern examples are built on the notion of looking for the right handler,
// launching it and exiting the chain after that.
// ""But here we execute every handler until there’s one that can’t handle a request."""
// Be aware that this still is the Chain of Responsibility pattern,
// even though the flow is a bit different.

abstract class Middleware {
  Middleware? _next;

  /// Builds chains of middleware objects.
  Middleware linkWith(Middleware next) {
    _next = next;
    return next;
  }

  /// Runs check on the next object in chain or ends traversing if we're in
  /// last object in chain.
  bool checkNext(String email, String password) {
    if (_next == null) {
      return true;
    } else {
      return _next!.check(email, password);
    }
  }

  /// Subclasses will implement this method with concrete checks.
  bool check(String email, String password);
}

/// Check _request amount limit
/// ConcreteHandler. Checks whether there are too many failed login _requests.
class ThrottlingMiddleware extends Middleware {
  int _requestPerMinute;
  int? _request;
  int _currentTime;

  ThrottlingMiddleware(int requestPerMinute)
      : _requestPerMinute = requestPerMinute,
        _currentTime = DateTime.now().millisecond;

  /**
     * Please, not that checkNext() call can be inserted both in the beginning
     * of this method and in the end.
     *
     * This gives much more flexibility than a simple loop over all middleware
     * objects. For instance, an element of a chain can change the order of
     * checks by running its check after all other checks.
     */
  @override
  bool check(String email, String password) {
    if (DateTime.now().millisecond > _currentTime + 60000) {
      _request = 0;
      _currentTime = DateTime.now().millisecond;
    }

    if (_request != null) {
      _request = _request! + 1;
    } else {
      _request = 0;
    }

    if (_request! > _requestPerMinute) {
      print("_Request limit exceeded!");
      print('---stop!!');
    }
    return checkNext(email, password);
  }
}

//    Check user’s credentials
// ConcreteHandler. Checks whether a user with the given credentials exists.
class UserExistsMiddleware extends Middleware {
  Server _server;
  UserExistsMiddleware(Server server) : _server = server;

  @override
  bool check(String email, String password) {
    if (!_server.hasEmail(email)) {
      print("This email is not registered!");
      return false;
    }
    if (!_server.isValidPassword(email, password)) {
      print("Wrong password!");
      return false;
    }
    return checkNext(email, password);
  }
}

//   Check user’s role
class RoleCheckMiddleware extends Middleware {
  @override
  bool check(String email, String password) {
    if (email == "admin@example.com") {
      print("Hello, admin!");
      return true;
    }
    print("Hello, user!");
    return checkNext(email, password);
  }
}

// Authorization target
// Server class.
class Server {
  final Map<String, String> _users = {};
  late Middleware _middleware;

  /**
     * Client passes a chain of object to server. This improves flexibility and
     * makes testing the server class easier.
     */
  void setMiddleware(Middleware middleware) => _middleware = middleware;

  /**
     * Server gets email and password from client and sends the authorization
     * _request to the chain.
     */
  bool logIn(String email, String password) {
    if (_middleware.check(email, password)) {
      print("Authorization have been successful!");
      // check mail and password .
      if (email.contains('@') && password.length >= 4) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  void register(String email, String password) => _users[email] = password;
  bool hasEmail(String email) => _users.containsKey(email);
  bool isValidPassword(String email, String password) =>
      _users[email] == password;
}

/// Demo main(). Everything comes together here.
void main() {
  Server server = Server();
  server.register("admin@example.com", "admin_pass");
  server.register("user@example.com", "user_pass");

  // All checks are linked. Client can build various chains using the same
  // components.
  Middleware middleware = ThrottlingMiddleware(2);
  middleware
      .linkWith(UserExistsMiddleware(server))
      .linkWith(RoleCheckMiddleware());

  // Server gets a chain from client code.
  server.setMiddleware(middleware);

  print("----------------will fail----------------");
  server.logIn("hello", "password");
  server.logIn("hello@fish", "password");
  server.logIn("hello@fish", "a");
  server.logIn("admin@example.com", "pas");
  server.logIn("admin@example.com", "password2");
  print("----------------will success admin----------------");
  server.logIn("admin@example.com", "admin_pass");
  print("----------------will success user----------------");
  server.logIn("user@example.com", "user_pass");
}
