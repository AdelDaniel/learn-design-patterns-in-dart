// behavioral_design_patterns/visitor/area_example.dart

import 'dart:math' as math;
// Example of Visitor Design Pattern:
// Below is the problem statement to understand visitor design pattern:

// Assume a situation whereby you have a set of shapes like circles, squares, and triangles.
// You want to find the area of each given figure.
// One option is to add a method that calculates the area of each shape class.
// Yet, it breaks the open-closed principle, as modifying existing classes is mandatory whenever a  operation emerges.
// There are the following steps for implementing Visitor Design Method:

// How to Implement Visitor Design Pattern?
// The Visitor design pattern works by separating an algorithm from the objects on which it operates, allowing you to add new operations without changing the existing object structures. Below is how it functions:

// Step 1: First, you define an interface for the elements (objects) that will accept visitors. This interface usually includes a method for accepting a visitor.
// Step 2: Then, you create concrete classes that implement the element interface. Each class represents an object in your structure and includes the method to accept a visitor.
// Step 3: Next, you define a visitor interface that declares a visit method for each concrete element type. This method will be called when a visitor visits a specific element.
// Step 4: You implement one or more concrete visitor classes, each providing specific operations for the various element types. Each visit method contains the logic for what to do when visiting that element.
// Step 5: When a visitor is applied to an element, the element calls the appropriate visit method on the visitor, passing itself as an argument. This allows the visitor to operate on the element and perform the desired actions.

/// Step 1: Define the Visitor interface:
abstract interface class ShapeVisitor {
  void visitCircle(Circle circle);
  void visitSquare(Square square);
  void visitTriangle(Triangle triangle);
}

/// Step 2: Define the Element interface:
abstract interface class Shape {
  void accept(ShapeVisitor visitor);
}

/// Step 3: Implement Concrete Elements:
class Circle implements Shape {
  // Circle specific properties and methods
  @override
  void accept(ShapeVisitor visitor) => visitor.visitCircle(this);
}

class Square implements Shape {
  @override
  void accept(ShapeVisitor visitor) => visitor.visitSquare(this);
}

class Triangle implements Shape {
  @override
  void accept(ShapeVisitor visitor) => visitor.visitTriangle(this);
}

/// Step 4: Implement Concrete Visitors:
class AreaCalculator implements ShapeVisitor {
  double _totalArea = 0;
  double radiusOfCircle = 5;
  double sideOfSquare = 4;
  double baseOfTriangle = 3;
  double heightOfTriangle = 6;

  @override
  void visitCircle(Circle circle) {
    // Calculate area of circle and update totalArea
    _totalArea += math.pi * math.pow(radiusOfCircle, 2);
  }

  @override
  void visitSquare(Square square) {
    // Calculate area of square and update totalArea
    _totalArea += math.pow(sideOfSquare, 2);
  }

  @override
  void visitTriangle(Triangle triangle) {
    // Calculate area of triangle and update totalArea
    _totalArea += (baseOfTriangle * heightOfTriangle) / 2;
  }

  double getTotalArea() => _totalArea;
}

/// Step 4: Implement Concrete Visitors:
class PerimeterCalculator implements ShapeVisitor {
  double _totalPerimeter = 0;
  double radiusOfCircle = 5;
  double sideOfSquare = 4;
  double baseOfTriangle = 3;
  double heightOfTriangle = 6;

  @override
  void visitCircle(Circle circle) {
    _totalPerimeter += math.pi * radiusOfCircle * 2;
  }

  @override
  void visitSquare(Square square) {
    _totalPerimeter += sideOfSquare * 4;
  }

  @override
  void visitTriangle(Triangle triangle) {
    _totalPerimeter += (baseOfTriangle + heightOfTriangle) * 2;
  }

  double getTotalPerimeter() => _totalPerimeter;
}

// Main class

void main(args) {
  List<Shape> shapes = [Circle(), Square(), Triangle()];

  AreaCalculator areaCalculator = AreaCalculator();
  for (Shape shape in shapes) {
    shape.accept(areaCalculator);
  }
  print("Total area: ${areaCalculator.getTotalArea()}");
}




// Total area: 103.53981

