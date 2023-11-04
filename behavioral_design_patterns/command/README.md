<div id="top"></div>

# Command

- Also known as: Action, Transaction

- **Four terms always associated with the command pattern are `command`, `receiver`, `invoker(Sender)` and `client`.**

## Problem

Suppose you are building a home automation system. There is a programmable remote which can be used to turn on and off various items in your home like lights, stereo, AC etc. It looks something like this. _You can do it with simple if-else statements_

```
if (buttonPressed == button1)
     lights.on()
```

But we need to keep in mind that turning on some devices like stereo comprises of many steps like setting cd, volume etc. Also we can reassign a button to do something else. By using simple if-else we are coding to implementation rather than interface. Also there is tight coupling.

So what we want to achieve is a design that provides

1. loose coupling
2. remote control should not have much information about a particular device.

---

<img style="background-color:#554777" align="center" src = "assets/structure_command.png">

<details>
  <summary> <h2 style="display: inline;">  Sections</h2> </summary>

- [Definitions](#Definitions)
- <a href="#when-to-use">When to use</a>
- [What problems can it solve](#What-problems-can-it-solve)
- <p><a href="#Examples">Examples</a></p>
- <p><a href="#Summery">Summery</a></p>
- <p><a href="#How_To_Implement">How_To_Implement</a></p>
- [Sources](#Sources)
</details>

## Definitions

### geeksforgeeks:

- encapsulates a request as an object,
- thereby letting us parameterize other objects with different (`requests`, `queue` or `log requests`),
- and support `undoable operations`.
- Parameterizing other objects with different requests: means that the button used to turn on the lights can later be used to turn on stereo or maybe open the garage door.
- queue or log requests, and support undoable operations: means

  - Command’s Execute operation can store state for reversing its effects in the Command itself.
  - The Command may have an added unExecute operation that reverses the effects of a previous call to execute.
  - It may also support logging changes so that they can be reapplied in case of a system crash

- example: command_remote_control_example.dart

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

1. Declare the command interface with a single execution method.

2. Start extracting requests into concrete command classes that implement the command interface.

   - Each class must have a set of fields for storing the request arguments along with a reference to the actual receiver object.
   - All these values must be initialized via the command’s constructor.

3. Identify classes that will act as senders.

   - Add the fields for storing commands into these classes.
   - Senders should communicate with their commands only via the command interface.
   - Senders usually don’t create command objects on their own, but rather get them from the client code.

4. Change the senders so they execute the command instead of sending a request to the receiver directly.

5. The client should initialize objects in the following order:

   1. Create receivers.
   2. Create commands, and associate them with receivers if needed.
   3. Create senders, and associate them with specific commands

---

<h3 id="Advantages:"> Advantages:</h3>

<h3 id=" Disadvantages:">  Disadvantages:</h3>

<h3 id=" Real-Life-Uses">Real Life Uses:</h3>

## Sources

1. https://www.geeksforgeeks.org/command-pattern/
2. https://www.tutorialspoint.com/design_pattern/command_pattern.htm
3. https://github.com/scottt2/design-patterns-in-dart/tree/master/command
4. https://refactoring.guru/design-patterns/command

<img src = "assets/structure_command.png">

<p align="right">(<a href="#top">back to top</a>)</p>
