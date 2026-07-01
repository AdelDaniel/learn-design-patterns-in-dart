// structural_design_pattern/composite/examples/shapes.dart
/// Composite is a structural design pattern
/// that lets you compose objects into tree structures and then work with these structures as if they were individual objects.
/// 
/// Composite became a pretty popular solution for most problems that require building a tree structure. 
/// Composite’s great feature is the ability to run methods recursively over the whole tree structure and sum up the results.
/// 
/// Usage examples: 
/// The Composite pattern is often used to represent hierarchies of user interface components 
/// or the code that works with graphs.
/// 
/// Identification: 
/// If you have an object tree, and each object of a tree is a part of the same class hierarchy, this is most likely a composite.
/// If methods of these classes delegate the work to child objects of the tree and do it via the base class/interface of the hierarchy, this is definitely a composite.
/// 
/// Example: Simple and compound graphical shapes
/// This example shows how to create complex graphical shapes, composed of simpler shapes and treat both of them uniformly.
library;


enum Color {
  blue,
  red,
  green,
  black,
  lightGray,
}

class Graphics {
  Color? _color;

  void setColor(Color color) {
    _color = color;
  }

  void drawRect(int x, int y, int width, int height) {
    print('Graphics: Draw rectangle at ($x, $y) with width $width, height $height (Color: $_color)');
  }

  void fillRect(int x, int y, int width, int height) {
    print('Graphics: Fill rectangle at ($x, $y) with width $width, height $height (Color: $_color)');
  }

  void drawOval(int x, int y, int width, int height) {
    print('Graphics: Draw oval at ($x, $y) with width $width, height $height (Color: $_color)');
  }
}

/// Common shape interface
abstract interface class Shape {
  int getX();
  int getY();
  int getWidth();
  int getHeight();
  void move(int x, int y);
  bool isInsideBounds(int x, int y);
  void select();
  void unSelect();
  bool isSelected();
  void paint(Graphics graphics);
}

/// Abstract shape with basic functionality
abstract class BaseShape implements Shape {
  int x;
  int y;
  Color color;
  bool _selected = false;

  BaseShape(this.x, this.y, this.color);

  @override
  int getX() => x;

  @override
  int getY() => y;

  @override
  int getWidth() => 0;

  @override
  int getHeight() => 0;

  @override
  void move(int x, int y) {
    this.x += x;
    this.y += y;
  }

  @override
  bool isInsideBounds(int x, int y) {
    return x >= getX() && x <= (getX() + getWidth()) &&
           y >= getY() && y <= (getY() + getHeight());
  }

  @override
  void select() {
    _selected = true;
  }

  @override
  void unSelect() {
    _selected = false;
  }

  @override
  bool isSelected() => _selected;

  void enableSelectionStyle(Graphics graphics) {
    graphics.setColor(Color.lightGray);
  }

  void disableSelectionStyle(Graphics graphics) {
    graphics.setColor(color);
  }

  @override
  void paint(Graphics graphics) {
    if (isSelected()) {
      enableSelectionStyle(graphics);
    } else {
      disableSelectionStyle(graphics);
    }
  }
}

/// A dot
class Dot extends BaseShape {
  static const int dotSize = 3;

  Dot(super.x, super.y, super.color);

  @override
  int getWidth() => dotSize;

  @override
  int getHeight() => dotSize;

  @override
  void paint(Graphics graphics) {
    super.paint(graphics);
    graphics.fillRect(x - 1, y - 1, getWidth(), getHeight());
  }
}

/// A circle
class Circle extends BaseShape {
  int radius;

  Circle(super.x, super.y, this.radius, super.color);

  @override
  int getWidth() => radius * 2;

  @override
  int getHeight() => radius * 2;

  @override
  void paint(Graphics graphics) {
    super.paint(graphics);
    graphics.drawOval(x, y, getWidth() - 1, getHeight() - 1);
  }
}

/// A rectangle
class Rectangle extends BaseShape {
  int width;
  int height;

  Rectangle(super.x, super.y, this.width, this.height, super.color);

  @override
  int getWidth() => width;

  @override
  int getHeight() => height;

  @override
  void paint(Graphics graphics) {
    super.paint(graphics);
    graphics.drawRect(x, y, getWidth() - 1, getHeight() - 1);
  }
}

/// Compound shape, which consists of other shape objects
class CompoundShape extends BaseShape {
  final List<Shape> children = [];

  CompoundShape([List<Shape> components = const []]) : super(0, 0, Color.black) {
    addAll(components);
  }

  void add(Shape component) {
    children.add(component);
  }

  void addAll(List<Shape> components) {
    children.addAll(components);
  }

  void remove(Shape child) {
    children.remove(child);
  }

  void removeAll(List<Shape> components) {
    children.removeWhere((element) => components.contains(element));
  }

  void clear() {
    children.clear();
  }

  @override
  int getX() {
    if (children.isEmpty) {
      return 0;
    }
    int x = children[0].getX();
    for (var child in children) {
      if (child.getX() < x) {
        x = child.getX();
      }
    }
    return x;
  }

  @override
  int getY() {
    if (children.isEmpty) {
      return 0;
    }
    int y = children[0].getY();
    for (var child in children) {
      if (child.getY() < y) {
        y = child.getY();
      }
    }
    return y;
  }

  @override
  int getWidth() {
    int maxWidth = 0;
    int x = getX();
    for (var child in children) {
      int childsRelativeX = child.getX() - x;
      int childWidth = childsRelativeX + child.getWidth();
      if (childWidth > maxWidth) {
        maxWidth = childWidth;
      }
    }
    return maxWidth;
  }

  @override
  int getHeight() {
    int maxHeight = 0;
    int y = getY();
    for (var child in children) {
      int childsRelativeY = child.getY() - y;
      int childHeight = childsRelativeY + child.getHeight();
      if (childHeight > maxHeight) {
        maxHeight = childHeight;
      }
    }
    return maxHeight;
  }

  @override
  void move(int x, int y) {
    for (var child in children) {
      child.move(x, y);
    }
  }

  @override
  bool isInsideBounds(int x, int y) {
    for (var child in children) {
      if (child.isInsideBounds(x, y)) {
        return true;
      }
    }
    return false;
  }

  @override
  void unSelect() {
    super.unSelect();
    for (var child in children) {
      child.unSelect();
    }
  }

  bool selectChildAt(int x, int y) {
    for (var child in children) {
      if (child.isInsideBounds(x, y)) {
        child.select();
        return true;
      }
    }
    return false;
  }

  @override
  void paint(Graphics graphics) {
    if (isSelected()) {
      enableSelectionStyle(graphics);
      graphics.drawRect(getX() - 1, getY() - 1, getWidth() + 1, getHeight() + 1);
      disableSelectionStyle(graphics);
    }

    for (var child in children) {
      child.paint(graphics);
    }
  }
}

/// Shape editor
class ImageEditor {
  final CompoundShape allShapes = CompoundShape();

  ImageEditor();

  void loadShapes(List<Shape> shapes) {
    allShapes.clear();
    allShapes.addAll(shapes);
  }

  void paint() {
    final graphics = Graphics();
    print('--- Image Editor Paint Start ---');
    allShapes.paint(graphics);
    print('--- Image Editor Paint End ---\n');
  }

  void mousePressed(int x, int y) {
    print('--- Clicked at ($x, $y) ---');
    allShapes.unSelect();
    if (allShapes.selectChildAt(x, y)) {
      print('Selected a shape!');
    } else {
      print('No shape selected.');
    }
  }
}

/// Client code
void main() {
  final editor = ImageEditor();

  editor.loadShapes([
    Circle(10, 10, 10, Color.blue),
    CompoundShape([
      Circle(110, 110, 50, Color.red),
      Dot(160, 160, Color.red),
    ]),
    CompoundShape([
      Rectangle(250, 250, 100, 100, Color.green),
      Dot(240, 240, Color.green),
      Dot(240, 360, Color.green),
      Dot(360, 360, Color.green),
      Dot(360, 240, Color.green),
    ]),
  ]);

  print('Painting initial shapes:');
  editor.paint();

  print('Simulating selection at (115, 115):');
  editor.mousePressed(115, 115);
  editor.paint();

  print('Simulating selection at (240, 240):');
  editor.mousePressed(240, 240);
  editor.paint();

  print('Moving all shapes by (10, 10):');
  editor.allShapes.move(10, 10);
  editor.paint();
}
