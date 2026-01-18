// behavioral_design_patterns/visitor/shapes_example.dart
/// Visitor Design Pattern:
/// is a behavioral design pattern that allows adding  behaviors to existing class hierarchy
/// without altering any existing code.

///
/// Usage examples: Visitor isn’t a very common pattern
/// because of its complexity and narrow applicability.
///

/// Exporting shapes into XML
/// In this example,
/// We would want to export a set of geometric shapes into XML.
/// The catch is that we don’t want to change the code of shapes directly or at least keep it to the minimum.

/// In the end, the Visitor pattern establishes an infrastructure that allows us to add any behaviors to the shapes hierarchy without changing the existing code of those classes.

/// shapes
/// Common shape interface
abstract interface class Shape {
  void move(int x, int y);
  void draw();
  String accept(Visitor visitor);
}

/// A dot
class Dot implements Shape {
  final int _id;
  final int _x;
  final int _y;

  const Dot(this._id, this._x, this._y);

  /// move shape
  @override
  void move(int x, int y) {}

  /// draw shape
  @override
  void draw() {}

  @override
  String accept(Visitor visitor) {
    return visitor.visitDot(this);
  }

  int getX() => _x;

  int getY() => _y;

  int getId() => _id;
}

/// A circle
class Circle extends Dot {
  final int _radius;

  const Circle(super.id, super.x, super.y, int radius) : _radius = radius;

  @override
  String accept(Visitor visitor) {
    return visitor.visitCircle(this);
  }

  int getRadius() => _radius;
}

/// A rectangle
class Rectangle implements Shape {
  final int _id;
  final int _x;
  final int _y;
  final int _width;
  final int _height;

  Rectangle(int id, int x, int y, int width, int height)
      : _id = id,
        _x = x,
        _y = y,
        _width = width,
        _height = height;

  @override
  String accept(Visitor visitor) {
    return visitor.visitRectangle(this);
  }

  @override
  void move(int x, int y) {
    // move shape
  }

  @override
  void draw() {
    // draw shape
  }

  int getId() => _id;

  int getX() => _x;

  int getY() => _y;

  int getWidth() => _width;

  int getHeight() => _height;
}

/// A compound shape
class CompoundShape implements Shape {
  final int _id;
  List<Shape> children = [];

  CompoundShape(int id) : _id = id;

  // move shape
  @override
  void move(int x, int y) {}
  // draw shape
  @override
  void draw() {}

  int getId() => _id;

  @override
  String accept(Visitor visitor) {
    return visitor.visitCompoundGraphic(this);
  }

  void add(Shape shape) {
    children.add(shape);
  }
}

/// visitor
/// Common visitor interface
abstract interface class Visitor {
  String visitDot(Dot dot);

  String visitCircle(Circle circle);

  String visitRectangle(Rectangle rectangle);

  String visitCompoundGraphic(CompoundShape cg);
}

/// Concrete visitor, exports all shapes into XML

class XMLExportVisitor implements Visitor {
  String export(List<Shape> args) {
    StringBuffer sb = StringBuffer();
    sb.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
    for (Shape shape in args) {
      sb.writeln(shape.accept(this));
    }
    return sb.toString();
  }

  @override
  String visitDot(Dot d) {
    return "<dot>\n"
        "    <id>"
        '${d.getId()}'
        "</id>\n"
        "    <x>"
        '${d.getX()}'
        "</x>\n"
        "    <y>"
        '${d.getY()}'
        "</y>\n"
        "</dot>";
  }

  @override
  String visitCircle(Circle c) {
    return "<circle>\n"
        "    <id>"
        '${c.getId()}'
        "</id>\n"
        "    <x>"
        '${c.getX()}'
        "</x>\n"
        "    <y>"
        '${c.getY()}'
        "</y>\n"
        "    <radius>"
        '${c.getRadius()}'
        "</radius>\n"
        "</circle>";
  }

  @override
  String visitRectangle(Rectangle r) {
    return "<rectangle>\n"
        "    <id>"
        '${r.getId()}'
        "</id>\n"
        "    <x>"
        '${r.getX()}'
        "</x>\n"
        "    <y>"
        '${r.getY()}'
        "</y>\n"
        "    <width>"
        '${r.getWidth()}'
        "</width>\n"
        "    <height>"
        '${r.getHeight()}'
        "</height>\n"
        "</rectangle>";
  }

  @override
  String visitCompoundGraphic(CompoundShape cg) {
    return "${"<compound_graphic>" "\n" "   <id>" '${cg.getId()}'}</id>\n${_visitCompoundGraphic(cg)}</compound_graphic>";
  }

  String _visitCompoundGraphic(CompoundShape cg) {
    StringBuffer sb = StringBuffer();
    for (Shape shape in cg.children) {
      String obj = shape.accept(this);
      // Proper indentation for sub-objects.
      obj = "    ${obj.replaceAll("\n", "\n    ")}\n";
      sb.write(obj);
    }
    return sb.toString();
  }
}

/// Client code

void main() {
  Dot dot = Dot(1, 10, 55);
  Circle circle = Circle(2, 23, 15, 10);
  Rectangle rectangle = Rectangle(3, 10, 17, 20, 30);

  CompoundShape compoundShape = CompoundShape(4);
  compoundShape.add(dot);
  compoundShape.add(circle);
  compoundShape.add(rectangle);

  CompoundShape c = CompoundShape(5);
  c.add(dot);
  compoundShape.add(c);

  export([compoundShape]);
}

void export(List<Shape> shapes) {
  XMLExportVisitor exportVisitor = XMLExportVisitor();
  print(exportVisitor.export(shapes));
}

//  OutputDemo.txt: Execution result
// <?xml version="1.0" encoding="utf-8"?>
// <circle>
//     <id>2</id>
//     <x>23</x>
//     <y>15</y>
//     <radius>10</radius>
// </circle>

// <?xml version="1.0" encoding="utf-8"?>
// <compound_graphic>
//    <id>4</id>
//     <dot>
//         <id>1</id>
//         <x>10</x>
//         <y>55</y>
//     </dot>
//     <circle>
//         <id>2</id>
//         <x>23</x>
//         <y>15</y>
//         <radius>10</radius>
//     </circle>
//     <rectangle>
//         <id>3</id>
//         <x>10</x>
//         <y>17</y>
//         <width>20</width>
//         <height>30</height>
//     </rectangle>
//     <compound_graphic>
//        <id>5</id>
//         <dot>
//             <id>1</id>
//             <x>10</x>
//             <y>55</y>
//         </dot>
//     </compound_graphic>
// </compound_graphic>
