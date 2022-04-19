import 'example_models.dart';
import 'exceptions.dart';
import 'handlers.dart';

void main(List<String> args) {
  BaseHandler loyaltyHandler = LoyaltyHandler();
  BaseHandler orderHandler = OrderHandler();
  BaseHandler productAvailabilityHandler = ProductAvailabilityHandler();
  BaseHandler shipmentHandler = ShipmentHandler();

  loyaltyHandler.setNextHandler(shipmentHandler);
  shipmentHandler.setNextHandler(productAvailabilityHandler);
  productAvailabilityHandler.setNextHandler(orderHandler);

  BaseHandler chainHandlers = loyaltyHandler;

  Order availableOrderWithLoyalUser = Order(User('USR-100', "name"),
      Product('PRD-1', "product Name"), DateTime.parse("2021-02-01"));
  chainHandlers.handle(availableOrderWithLoyalUser);
  print('--------------------------------------');
  try {
    Order notAvailableOrderWithLoyalUser = Order(User('USR-100', "name"),
        Product('no', "productName"), DateTime.parse("2021-02-01"));
    chainHandlers.handle(notAvailableOrderWithLoyalUser);
  } on CustomException catch (e) {
    print(e.message);
  }
  print('--------------------------------------');
  try {
    Order orderWithNotLoyalUser = Order(User('not exist user', "name"),
        Product('PRD-1', "productName"), DateTime.parse("2021-02-01"));
    chainHandlers.handle(orderWithNotLoyalUser);
  } on CustomException catch (e) {
    print(e.message);
  }
  print('--------------------------------------');
  try {
    Order shipTimeOrder = Order(User('USR-100', "name"),
        Product('PRD-1', "product Name"), DateTime.parse("2019-02-01"));
    chainHandlers.handle(shipTimeOrder);
  } on CustomException catch (e) {
    print(e.message);
  }
}
