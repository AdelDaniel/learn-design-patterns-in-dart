//!
//! BAD EXAMPLE FROM TUTORIAL POINT
//! Source:: https://www.tutorialspoint.com/design_pattern/facade_pattern.htm

// ShapeMaker class uses the concrete classes to delegate user calls to these classes.
// main, our demo class, will use ShapeMaker class to show the results.

// Step 1
// Create an interface.
abstract class IShape {
  void draw();
}

// Step 2
// Create concrete classes implementing the same interface.
class Rectangle implements IShape {
  @override
  void draw() => print("Rectangle::draw()");
}

class Square implements IShape {
  @override
  void draw() => print("Square::draw()");
}

class Circle implements IShape {
  @override
  void draw() => print("Circle::draw()");
}

// Step 3
// Create a facade class.
class ShapeMaker {
  IShape _circle;
  IShape _rectangle;
  IShape _square;

  ShapeMaker()
      : _circle = Circle(),
        _rectangle = Rectangle(),
        _square = Square();

  void drawCircle() => _circle.draw();
  void drawRectangle() => _rectangle.draw();
  void drawSquare() => _square.draw();
}

// Step 4
// Use the facade to draw various types of shapes.
void main() {
  ShapeMaker shapeMaker = ShapeMaker();

  shapeMaker.drawCircle();
  shapeMaker.drawRectangle();
  shapeMaker.drawSquare();
}

// Step 5
// output.
// Circle::draw()
// Rectangle::draw()
// Square::draw()
