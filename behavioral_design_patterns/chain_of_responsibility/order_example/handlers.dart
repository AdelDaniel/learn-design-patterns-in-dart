import 'example_models.dart';
import 'exceptions.dart';
import 'services.dart';

abstract class Handler {
  setNextHandler(Handler handler);
  handle(Order order);
}

abstract class BaseHandler implements Handler {
  Handler? _nextHandler;

  setNextHandler(Handler handler) {
    _nextHandler = handler;
    return _nextHandler;
  }

  Handler? getNextHandler() => _nextHandler;

  void handleNextOrderIfExist(Order order) {
    if (getNextHandler() != null) {
      getNextHandler()!.handle(order);
    }
  }
}

class LoyaltyHandler extends BaseHandler {
  handle(Order order) {
    IsUserLoyalApplication loyaltyService = IsUserLoyalApplication();
    if (loyaltyService.isUserLoyal(order.getUser())) {
      print("Hello loyal user");
      super.handleNextOrderIfExist(order);
    } else {
      print("not loyal user");
      throw NoLoyalUserException();
    }
  }
}

class OrderHandler extends BaseHandler {
  handle(Order order) {
    AddOrderApplication orderService = AddOrderApplication();
    orderService.addOrder(order);
    String printedMsg =
        """ The order of ${order.getUser().getName()}  
            contains ${order.getProduct().getName()} 
            and will be shipped by 
            ${order.getShipmentDate().toUtc()}\n """;
    print(printedMsg);
    super.handleNextOrderIfExist(order);
  }
}

class ProductAvailabilityHandler extends BaseHandler {
  handle(Order order) {
    IsProductAvailableApplication productAvailabilityService =
        IsProductAvailableApplication();
    if (productAvailabilityService.isProductAvailable(order.getProduct())) {
      print("product Available");
      super.handleNextOrderIfExist(order);
    } else {
      print("product NOt Available");
      throw NoProductAvailableException();
    }
  }
}

class ShipmentHandler extends BaseHandler {
  handle(Order order) {
    HasShipmentTruckAvailableApplication productAvailabilityService =
        HasShipmentTruckAvailableApplication();
    if (productAvailabilityService.hasShipmentTruckAvailable(order)) {
      super.handleNextOrderIfExist(order);
    } else {
      throw NoShipmentAvailableException();
    }
  }
}
