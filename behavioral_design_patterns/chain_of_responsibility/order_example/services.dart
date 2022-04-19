import 'example_models.dart';

class AddOrderApplication {
  List _orders = [];
  addOrder(Order order) => _orders.add(order);
}

class IsUserLoyalApplication {
  Map<String, int> _loyaltyDirectory = {
    'USR-100': 5,
    'USR-101': 7,
    'USR-103': 3
  };
  bool isUserLoyal(User user) => (_loyaltyDirectory[user.getId()] ?? 0) >= 5;
}

class IsProductAvailableApplication {
  Map<String, int> _productsAvailability = {
    'PRD-1': 10,
    'PRD-2': 73,
    'PRD-3': 0
  };
  bool isProductAvailable(Product product) =>
      (_productsAvailability[product.getId()] ?? 0) > 0;
}

class HasShipmentTruckAvailableApplication {
  Map<String, String> _shipmentAvailability = {
    'TRK-1': "2022-01-01",
    'TRK-2': "2021-01-01",
    'TRK-3': "2020-01-01",
  };

  bool hasShipmentTruckAvailable(Order order) {
    for (String shipmentDate in _shipmentAvailability.values) {
      if (order.getShipmentDate().isAfter(DateTime.parse(shipmentDate))) {
        return true;
      }
    }
    return false;
  }
}
