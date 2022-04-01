/// From Tutorial Point:: https://www.tutorialspoint.com/design_pattern/factory_pattern.htm

//! Step 1
// Create an  abstract class.

abstract class IShape {
  const IShape();
  void draw();
}
//! Step 2
// Create concrete classes implementing the same  abstract class.

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
//! Step 3
// Create a Factory to generate object of concrete class based on given information.

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

// Step 4
// Use the Factory to get object of concrete class by passing an information such as type.
void main() {
  //get an object of Circle and call its draw method.
  IShape shape1 = ShapeFactory.getShape(ShapeType.CIRCLE);

  //call draw method of Circle
  shape1.draw();

  //get an object of Rectangle and call its draw method. then draw it
  IShape shape2 = ShapeFactory.getShape(ShapeType.RECTANGLE);
  shape2.draw();

  //get an object of Square and call its draw method.
  IShape shape3 = ShapeFactory.getShape(ShapeType.SQUARE);
  shape3.draw();
}
