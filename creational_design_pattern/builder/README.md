# Builder Pattern

**`< construct a complex object from simple objects using step-by-step approach >`**

    - is a creational pattern. 
    - Separate the construction of a complex object from its representation so that the same construction process can create different representations.”
    - It is used to construct a complex object step by step and the final step will return the object.
    - The process of constructing an object should be generic so that it can be used to create different representations of the same object.

## Sections

- [Examples](#Examples)
    - [CD Example](#CD-Example)
    - [Computer Example](#Computer-Example)
    - [Pizza Builder](#Pizza-Builder)
- [TO DO](#TO-DO)

## Examples

### CD Example
source: [www.javatpoint.com/builder-design-pattern ](https://www.javatpoint.com/builder-design-pattern)

My Dart Code: [Click Here](cd_example/README.md)

---
### Computer Example
My Dart Code: [Click Here](computer_example/README.md)

---
### Pizza Builder 
source: [https://github.com/scottt2/design-patterns-in-dart/tree/master/builder](https://www.javatpoint.com/builder-design-pattern)



#### Pizza Class
  - takes the builder in constructor 
  - depend on that constructor >> Pizza class will return object 

```dart
class Pizza {
  String _crust;
  int _diameter;
  Set<String> _toppings;

  Pizza(PizzaBuilder builder) {
    _crust = builder.crust;
    _diameter = builder.diameter;
    _toppings = builder.toppings;
  }

  String get crust => _crust;
  int get diameter => _diameter;
  String get toppings => _stringifiedToppings();
  String _stringifiedToppings() {
    var stringToppings = _toppings.join(", ");
    var lastComma = stringToppings.lastIndexOf(",");
    var replacement = ",".allMatches(stringToppings).length > 1 ? ", and" : " and";

    return stringToppings.replaceRange(lastComma, lastComma + 1, replacement);
  }

  @override
  String toString() {
    return "A delicous $_diameter\" pizza with $_crust crust covered in $toppings";
  }
}

```

#### PizzaBuilder Class 

```dart
class PizzaBuilder {
  String _crust;
  int _diameter;
  Set<String> _toppings;

  PizzaBuilder(this._diameter);

  String get crust => _crust;
  set crust(String newCrust) => _crust = newCrust;

  int get diameter => _diameter;
  set diameter(int newDiameter) => _diameter = newDiameter;

  Set<String> get toppings => _toppings;
  set toppings(Set<String> newToppings) {
    _toppings = newToppings;
    _ensureCheese();
  }

  void _ensureCheese() => _toppings.add("cheese");
  

  Pizza build() => Pizza(this);
  
}

```
#### void Main() 


```dart
void main() {
  // Create a handy PizzaBuilder with an 8" diameter.
  var pizzaBuilder = PizzaBuilder(8);

  // Add some attributes to the builder.
  pizzaBuilder.crust = "deep dish";
  pizzaBuilder.toppings = Set.from(["pepperoni"]);

  // Let's make a pizza!
  var plainPizza = Pizza(pizzaBuilder);
  print("Behold! $plainPizza.");
  assert(plainPizza.toString() == "A delicous 8\" pizza with deep dish crust covered in pepperoni and cheese");

  //! Making another pizza with same builder 
  // Now to adjust some things for the next pizza...
  pizzaBuilder.crust = "gold plated";
  pizzaBuilder.diameter = 72;
  pizzaBuilder.toppings = Set.from(["anchovies", "caviar", "diamonds"]);

  // The beauty of the build is you can quickly iterate and produce instances of a class.
  // For example, we have an early employee of the latest unicorn in line. So much disposable income!
  // Also note, we use the .build() function of the builder this time.
  var luxuriousPizza = pizzaBuilder.build();
  print("Wow! $luxuriousPizza? Someone is rich!");
  assert(luxuriousPizza.toString() == "A delicous 72\" pizza with gold plated crust covered in anchovies, caviar, diamonds, and cheese");
}
```


## TO DO 

1- don't copy the code just convert uml to Dart
https://www.google.com/url?sa=i&url=https%3A%2F%2Fsceweb.sce.uhcl.edu%2Fhelm%2FWEBPAGES-SoftwareDesignPatterns%2Fmyfiles%2FTableContents%2FModule-6%2Fbuilder_pattern_builds_a_complex.html&psig=AOvVaw1LPgqwEqtvU4go8NfLl6as&ust=1648042325557000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCKD82KPq2fYCFQAAAAAdAAAAABAg


1- https://www.google.com/url?sa=i&url=https%3A%2F%2Fsourcemaking.com%2Fdesign_patterns%2Fbuilder&psig=AOvVaw1LPgqwEqtvU4go8NfLl6as&ust=1648042325557000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCKD82KPq2fYCFQAAAAAdAAAAABAO

2- buildings form here 
  https://refactoring.guru/design-patterns/builder

3- this huge pizza builder
  https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.javatpoint.com%2Fbuilder-design-pattern&psig=AOvVaw1LPgqwEqtvU4go8NfLl6as&ust=1648042325557000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCKD82KPq2fYCFQAAAAAdAAAAABAU