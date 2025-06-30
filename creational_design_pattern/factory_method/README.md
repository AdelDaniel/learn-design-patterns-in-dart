# Factory Method Pattern

Also known as: `Virtual Constructor`

    - is a creational pattern.
    - uses factory methods to deal with the problem of creating objects without having to specify the exact class of the object that will be created.

    This is done by creating objects by calling a factory method—either specified in an interface and implemented by child classes, or implemented in a base class and optionally overridden by derived classes—rather than by calling a constructor.

## Sections

- [Examples](#Examples)
  - [shape Example](#shape-Example)
  - [Dialog Example](#Dialog-Example)
  - [vessel volume Example](#vessel-volume-Example)
- [Resources](#Resources)

## Examples

### shape Example

source: [Tutorial Point java ](https://www.tutorialspoint.com/design_pattern/factory_pattern.htm)
<img src="assets/factory_pattern_uml_diagram.jpg" >

#### Step 1

Create an interface.

```dart
abstract class IShape {
  const IShape();
  void draw();
}
```

#### Step 2

Create concrete classes implementing the same interface.

```dart
class Rectangle implements IShape {
  @override
  void draw() => print("Inside Rectangle::draw() method.");
}

class Square implements IShape {
  @override
  void draw() => print("Inside Square::draw() method.");
}

class Circle implements IShape {
  @override
  void draw() => print("Inside Circle::draw() method.");
}
```

#### Step 3

Create a Factory to generate object of concrete class based on given information.

```dart
enum ShapeType { CIRCLE, RECTANGLE, SQUARE }

class ShapeFactory {
  //use getShape method to get object of type shape
  static IShape getShape(ShapeType shapeType) {
    switch (shapeType) {
      case ShapeType.CIRCLE:
        return Circle();
      case ShapeType.RECTANGLE:
        return Rectangle();
      case ShapeType.SQUARE:
        return Square();
      default:
        throw Exception("Not Exist Shape");
    }
  }
}
```

#### Step 4

Use the Factory to get object of concrete class by passing an information such as type.

```dart
void main() {
  //get an object of Circle and call its draw method.
  IShape shape1 = ShapeFactory.getShape(ShapeType.CIRCLE);

  //call draw method of Circle
  shape1.draw();

  //get an object of Rectangle and call its draw method.
  IShape shape2 = ShapeFactory.getShape(ShapeType.RECTANGLE);
  shape2.draw();

  //get an object of Square and call its draw method.
  IShape shape3 = ShapeFactory.getShape(ShapeType.SQUARE);
  shape3.draw();
}
```

---

### Dialog Example

    This example illustrates how the Factory Method can be used for creating cross-platform UI elements without coupling the client code to concrete UI classes.

- <strong><a href="dialog_example" target="_blank"> Dialog Example</a></strong>

---

### vessel volume Example

source: [Design Pattern in Dart ( factory method ) ](https://github.com/scottt2/design-patterns-in-dart/tree/master/factor_method)

`updated code in coffee_example.dart`

```dart
class Volume {
  final int quantity;
  final String unit;

  Volume(this.quantity, this.unit);
  String toString() => "$quantity $unit";
}

abstract class Vessel {
  Volume volume;
  String liquid;
}

class Bucket extends Vessel {
  final Volume volume;

  Bucket(int q, String u) : volume = Volume(q, u);
  String toString() => "a $volume bucket full of $liquid";
}

class Cup extends Vessel {
 final Volume volume;

  Cup(int q, String u) : volume = Volume(q, u);
  String toString() => "a $volume cup full of $liquid";
}

enum Tiredness {
  rested, sleepy, barelyAlive, hasChildren
}

class CoffeeVesselFactory {
  static Vessel vesselFor(Tiredness howTired) {
    Vessel vessel;
    switch(howTired) {
      case Tiredness.rested: vessel = Cup(100, "milliliter"); break;
      case Tiredness.sleepy:
      case Tiredness.barelyAlive: vessel = Cup(500, "milliliter"); break;
      case Tiredness.hasChildren: vessel = Bucket(5, "liter"); break;
      default: vessel = Cup(200, "milliliter"); break;
    }
    vessel.liquid = "coffee";
    return vessel;
  }
}

void main() {
  var sleepyVessel = CoffeeVesselFactory.vesselFor(Tiredness.sleepy);
  var kidVessel = CoffeeVesselFactory.vesselFor(Tiredness.hasChildren);

  // A sleepy person would like a 500 milliliter cup full of coffee.
  print("A sleepy person would like $sleepyVessel.");
  // A person with children NEEDS a 5 liter bucket full of coffee.
  print("A person with children NEEDS $kidVessel.");
}
```

## Resources

- [Wikipedia: Factory Method](https://en.wikipedia.org/wiki/Factory_method_pattern)

- [Design Pattern in Dart (factory method) ](https://github.com/scottt2/design-patterns-in-dart/tree/master/factor_method)
