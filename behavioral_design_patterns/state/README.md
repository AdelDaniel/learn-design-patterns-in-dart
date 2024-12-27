<div id="top"></div>

# State

## Definitions  
### Def 1: 
- behavioral design patterns.
- state design pattern is used when an **Object changes its behavior based on its internal state**.

- If we have to change the behavior of an object based on its `state`, we can have a state variable in the Object and use the if-else condition block to perform different actions based on the state.
- The state pattern is used to provide a `systematic` and `lose-coupled` way to achieve this through `Context` and `State` implementations.

### Def 2: https://www.geeksforgeeks.org/state-design-pattern/
- allows an object to alter its behavior when its internal state changes.
- useful when an object’s behavior depends on its state, 
- and the state can change during the object’s lifecycle.

---

### Context:
 - Defines an interface for clients to interact.
 - It maintains references to concrete state objects which may be used to define the current state of objects.
### State:
 - Defines interface for declaring what each concrete state should do.
### Concrete State:
 - Provides the implementation for methods defined in State.

## Problem

---

<img style="background-color:#554777" align="center" src = "assets/structure_command.png">

<details>
  <summary> <h2 style="display: inline;">  Sections</h2> </summary>

- [Definitions](#definitions)
- <a href="#when-to-use">When to use</a>
- [What problems can it solve](#What-problems-can-it-solve)
- <p><a href="#Examples">Examples</a></p>
- <p><a href="#Summery">Summery</a></p>
- <p><a href="#How_To_Implement">How_To_Implement</a></p>
- [Sources](#sources)

</details>

## Definitions

### geeksforgeeks


### tutorialspoint

- `Command pattern` is a data driven design pattern and falls under behavioral pattern category.
- A request is wrapped under an object as `command` and passed to `invoker` (Sender) object.
- Invoker object looks for the appropriate object which can handle this command and passes the command to the corresponding object which executes the command.

<h2 id="when-to-use" >When to use</h2>

---

<h2 id="Examples"> Examples</h2>

<img style="background-color:#554777" src = "assets/command_pattern_uml_diagram_stock_example.jpg">

- <a  href="command_stock_order_example.dart/"> command_stock_order_example</a>

```dart

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
```

```dart
/// Step 2
/// Create a request class.
class Stock {
  String _name = "ABC";
  int _quantity = 10;

  void buy() => log("Stock [ Name: $_name, Quantity: $_quantity  bought");

  void sell() => log("Stock [ Name: $_name, Quantity: $_quantity  sold");
}
```

```dart
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
```

```dart
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
```

```dart
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

/// Step 6: Verify the output.
/// Stock [ Name: ABC, Quantity: 10 ] bought
/// Stock [ Name: ABC, Quantity: 10 ] sold

```

---

- <a  href="command_terminal_example_with_history.dart/"> command_terminal_example_with_history.dart </a>

- <a  href="command_remote_control_example.dart/"> command_remote_control_example </a>
- <a  href="command_remote_control_easy_example.dart/"> command_remote_control_easy_example </a>

<h2 id="Summery"> Summery</h2>

---

<h2 id="How_To_Implement"> How To Implement </h2>


---

<h3 id="Advantages:"> Advantages:</h3>

<h3 id=" Disadvantages:">  Disadvantages:</h3>

<h3 id=" Real-Life-Uses">Real Life Uses:</h3>

## Sources

1. <https://www.geeksforgeeks.org/state-design-pattern/>
2. <https://www.tutorialspoint.com/design_pattern/command_pattern.htm>
3. <https://github.com/scottt2/design-patterns-in-dart/tree/master/command>
4. <https://refactoring.guru/design-patterns/command>

<img src = "assets/structure_command.png">

<p align="right">(<a href="#top">back to top</a>)</p>
