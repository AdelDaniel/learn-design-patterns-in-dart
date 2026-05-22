<div id="top"></div>

# Delegate Design Pattern

- The Delegate Design Pattern is used when one object needs to use another object to perform a task or action.
- It's like having a personal assistant – you delegate tasks to them, but you're still in charge.

<img style="background-color:#554777" src = "https://assets.alexandria.raywenderlich.com/books/des/images/c57492352703ffd13faa67205936b3bcb113947305da80d0be80770d0ceea10e/original.png">

## Sections

- [Delegate Design Pattern](#delegate-design-pattern)
  - [Sections](#sections)
  - [Definitions](#definitions)
  - [Components \&\& Diagrams (UML class || Sequence diagrams).](#components--diagrams-uml-class--sequence-diagrams)
  - [What problems can it solve || When to Use || Use Cases](#what-problems-can-it-solve--when-to-use--use-cases)
  - [Examples](#examples)
    - [Spell Example (Good)](#spell-example-good)
    - [Waiter](#waiter)
  - [Sources](#sources)

## Definitions

---

## Components && Diagrams (UML class || Sequence diagrams).

In this pattern, we have two main characters:

- `The Delegator` (The Boss): This is the object that sends the signal. Think of it as the boss giving orders.
- `The Delegate` (The Worker): This is the object that receives the signal and performs the action. It's like the employee carrying out the tasks.
- `protocols` (Contract): (similar to protocols in Swift) These protocols are like a contract between the Delegator and the Delegate.

---

## What problems can it solve || When to Use || Use Cases

Loose Coupling:
Protocols help in loosely coupling the objects. This means the Delegator and Delegate aren't tightly bound to each other.

Limited Access:
The Delegator only knows about the methods and properties defined in the protocol. It's like giving someone a to-do list without revealing all your secrets.

Reusability:
Can be used in various scenarios with different delegate implementations.

## Examples

### Spell Example (Good)

Dart Code: [link](examples/spell_example.dart)

### Waiter

```dart
// Protocol Definition / Delegation Interface
abstract class WaiterDelegate {
  void serveFood();
}

// Chef Class (Delegator)
class Chef {
  WaiterDelegate? delegate;

  // The function where the chef instructs the waiter to serve food
  void instructWaiterToServeFood() {
    print('Chef: The food is ready, waiter please serve it.');

    delegate?.serveFood();
  }
}

// Waiter Class (Delegate)
class Waiter implements WaiterDelegate {
  @override
  void serveFood() {
    print('Waiter: Serving the food to the table.');
  }
}

// Main Program
void main() {
  Chef chef = Chef(); // Chef object
  Waiter waiter = Waiter(); // Waiter object

  // Assigning the waiter as the delegate to the chef
  chef.delegate = waiter;

  // The chef instructs the waiter to serve the food
  chef.instructWaiterToServeFood();
}
```

## Sources

- https://dev.to/idolentbudha/understanding-the-delegate-design-pattern-1fph

<p align="right">(<a href="#top">back to top</a>)</p>
