import 'dart:developer';

/// We have created an interface Order which is acting as a command.
/// We have created a Stock class which acts as a request.
/// We have concrete command classes BuyStock and SellStock implementing Order interface
///     which will do actual command processing.
/// A class Broker is created which acts as an invoker object.
///     It can take and place orders.

/// Broker object uses command pattern to identify which object will execute which command based on the type of command.
///  CommandPatternDemo, our demo class, will use Broker class to demonstrate command pattern.

/// Step 1
/// Create a command interface.
abstract interface class Order {
  void execute();
}

/// Step 2
/// Create a request class.
class Stock {
  String _name = "ABC";
  int _quantity = 10;

  void buy() => log("Stock [ Name: $_name, Quantity: $_quantity  bought");

  void sell() => log("Stock [ Name: $_name, Quantity: $_quantity  sold");
}

/// Step 3
/// Create concrete classes implementing the Order interface.
class BuyStock implements Order {
  Stock _stock;

  BuyStock(this._stock);

  void execute() => _stock.buy();
}

class SellStock implements Order {
  Stock _stock;

  SellStock(this._stock);

  void execute() => _stock.sell();
}

/// Step 4
/// Create command invoker (Sender) class.
class Broker {
  List<Order> _orderList = [];

  void takeOrder(Order order) => _orderList.add(order);

  void placeOrders() {
    for (Order order in _orderList) {
      order.execute();
    }
    _orderList.clear();
  }
}

/// Step 5
/// Use the Broker class to take and execute commands.
void main() {
  Stock abcStock = Stock();

  /// Commands
  BuyStock buyStockOrder = BuyStock(abcStock);
  SellStock sellStockOrder = SellStock(abcStock);

  /// Invoker -> Sender
  Broker broker = Broker();
  broker.takeOrder(buyStockOrder);
  broker.takeOrder(sellStockOrder);

  broker.placeOrders();
}

/// Step 6
// Verify the output.

/// Stock [ Name: ABC, Quantity: 10 ] bought
/// Stock [ Name: ABC, Quantity: 10 ] sold
