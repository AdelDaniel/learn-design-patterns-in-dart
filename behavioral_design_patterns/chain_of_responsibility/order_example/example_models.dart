class Order {
  User _user;
  Product _product;
  DateTime _shipmentDate;

  Order(User user, Product product, DateTime shipmentDate)
      : _user = user,
        _product = product,
        _shipmentDate = shipmentDate;

  User getUser() => _user;
  Product getProduct() => _product;
  DateTime getShipmentDate() => _shipmentDate;
}

class Product {
  String _id;
  String _name;

  Product(String id, String name)
      : _id = id,
        _name = name;

  String getId() => _id;
  String getName() => _name;
}

class User {
  String _id;
  String _name;

  User(String id, String name)
      : _id = id,
        _name = name;

  String getId() => _id;
  String getName() => _name;
}
