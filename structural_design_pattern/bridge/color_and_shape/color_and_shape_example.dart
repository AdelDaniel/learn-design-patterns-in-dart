// Step 1
// Create bridge implementer interface.
abstract class DrawAPI {
  void drawCircle(int radius, int x, int y);
}

// Step 2
// Create concrete bridge implementer classes implementing the DrawAPI interface.
class RedCircle implements DrawAPI {
  @override
  void drawCircle(int radius, int x, int y) {
    print(
        "Drawing Circle[ color: red, radius: $radius, Centerpoint: ($x , $y) ]");
  }
}

class GreenCircle implements DrawAPI {
  @override
  void drawCircle(int radius, int x, int y) {
    print(
        "Drawing Circle[ color: green, radius: $radius, Centerpoint: ($x , $y) ]");
  }
}

// Step 3
// Create an abstract class Shape using the DrawAPI interface.
abstract class Shape {
  DrawAPI drawAPI;
  Shape(DrawAPI drawAPI) : drawAPI = drawAPI;
  void draw();
}

// Step 4
// Create concrete class implementing the Shape interface.
class Circle extends Shape {
  int _x, _y, _radius;

  Circle(int x, int y, int radius, DrawAPI drawAPI)
      : _x = x,
        _y = y,
        _radius = radius,
        super(drawAPI);

  void draw() => drawAPI.drawCircle(_radius, _x, _y);
}

// Step 5
// Use the Shape and DrawAPI classes to draw different colored circles.
void main() {
  Shape redCircle = Circle(100, 100, 10, RedCircle());
  Shape greenCircle = Circle(100, 100, 10, GreenCircle());

  redCircle.draw();
  greenCircle.draw();
}

// Step 6
// output.
// Drawing Circle[ color: red, radius: 10, x: 100, 100]
// Drawing Circle[  color: green, radius: 10, x: 100, 100]
