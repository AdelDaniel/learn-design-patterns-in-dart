//!--
//! in this example we will decorate a shape with some color
//! without alter (Change) shape class.
//!--
// Source: https://www.tutorialspoint.com/design_pattern/decorator_pattern.htm

// We're going to create a Shape interface and concrete classes implementing the Shape interface. We will then create an abstract decorator class ShapeDecorator implementing the Shape interface and having Shape object as its instance variable.
// RedShapeDecorator is concrete class implementing ShapeDecorator.
// DecoratorPatternDemo, our demo class will use RedShapeDecorator to decorate Shape objects.
// Decorator Pattern UML Diagram

// Step 1
// Create an interface.
abstract class IShape {
  void draw();
}

// Step 2
// Create concrete classes implementing the same interface.
class Rectangle implements IShape {
  @override
  void draw() => print("Shape: Rectangle");
}

class Circle implements IShape {
  @override
  void draw() => print("Shape: Circle");
}

// Step 3
// Create abstract decorator class implementing the Shape interface.
abstract class ShapeDecorator implements IShape {
  IShape decoratedShape;
  ShapeDecorator(IShape decoratedShape) : this.decoratedShape = decoratedShape;
  @override
  void draw() => decoratedShape.draw();
}

// Step 4
// Create concrete decorator class extending the ShapeDecorator class.
class RedShapeDecorator extends ShapeDecorator {
  RedShapeDecorator(IShape decoratedShape) : super(decoratedShape);

  @override
  void draw() {
    decoratedShape.draw();
    _setRedBorder(decoratedShape);
  }

  void _setRedBorder(IShape decoratedShape) {
    print("Border Color: Red");
  }
}

// Step 5
// Use the main() to decorate Shape objects.
void main(List<String> args) {
  IShape circle = Circle();
  IShape redCircle = RedShapeDecorator(Circle());
  IShape redRectangle = RedShapeDecorator(Rectangle());

  print("Circle with normal border");
  circle.draw();

  print("\nCircle of red border");
  redCircle.draw();

  print("\nRectangle of red border");
  redRectangle.draw();
}

// Step 6
// Verify the output.

// Circle with normal border
// Shape: Circle

// Circle of red border
// Shape: Circle
// Border Color: Red

// Rectangle of red border
// Shape: Rectangle
// Border Color: Red
