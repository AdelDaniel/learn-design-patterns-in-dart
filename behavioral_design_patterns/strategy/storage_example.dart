/// Storage Example
library;

/// This example shows a simple implementation of a list controller that is
/// able to display models from different data sources:
///
/// (MemoryStorage, CoreDataStorage, RealmStorage)
///

/// The ListController class is the context class that uses the DataSource
class ListController {
  DataSource? _dataSource;

  /// ... Reset current states ...
  void setDataSource({required DataSource dataSource}) => _dataSource = dataSource;

  /// Bind models to cells of a list view...
  void displayModels() {
    if (_dataSource != null) {
      final models = _dataSource!.loadModels();
      print("\nListController: Displaying models...");
      models.forEach(print);
    }
  }
}

abstract interface class DataSource {
  List<T> loadModels<T extends DomainModel>();
}

class MemoryStorage<Model> implements DataSource {
  List<Model>? _items;

  void add(List<Model> items) {
    if (_items == null) {
      _items = List.from(items);
    } else {
      _items?.addAll(items);
    }
  }

  List<T> loadModels<T extends DomainModel>() {
    if (_items?.isEmpty == true) {
      return [];
    }
    return _items as List<T>;
  }
}

class CoreDataStorage implements DataSource {
  @override
  List<T> loadModels<T extends DomainModel>() {
    final firstUser = User(id: 3, username: "username3");
    final secondUser = User(id: 4, username: "username4");
    return [firstUser, secondUser] as List<T>;
  }
}

class RealmStorage implements DataSource {
  @override
  List<T> loadModels<T extends DomainModel>() {
    final firstUser = User(id: 5, username: "username5");
    final secondUser = User(id: 6, username: "username6");
    return [firstUser, secondUser] as List<T>;
  }
}

class StrategyRealWorld {
  void test() {
    /// context and memory storage strategy
    final controller = ListController();
    final memoryStorage = MemoryStorage<User>();

    final networkUsers = _usersFromNetwork();
    memoryStorage.add(networkUsers);

    clientCode(controller, memoryStorage);
    clientCode(controller, CoreDataStorage());
    clientCode(controller, RealmStorage());
  }

  void clientCode(ListController controller, DataSource dataSource) {
    controller.setDataSource(dataSource: dataSource);
    controller.displayModels();
  }

  List<User> _usersFromNetwork() {
    final firstUser = User(id: 1, username: "username1");
    final secondUser = User(id: 2, username: "username2");
    return [firstUser, secondUser];
  }
}

void main() {
  StrategyRealWorld().test();
}

//  Output: Execution result
// ListController: Displaying models...
// User(id: 1, username: "username1")
// User(id: 2, username: "username2")

// ListController: Displaying models...
// User(id: 3, username: "username3")
// User(id: 4, username: "username4")

// ListController: Displaying models...
// User(id: 5, username: "username5")
// User(id: 6, username: "username6")

///
///
/// Domain Model And User Model
///
///
abstract interface class DomainModel {
  final int id;
  const DomainModel({required this.id});
}

class User implements DomainModel {
  final int id;
  final String username;
  User({required this.id, required this.username});

  @override
  String toString() => 'User(id: $id, username: $username)';
}
