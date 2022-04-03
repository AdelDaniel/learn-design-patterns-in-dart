// Wikipedia First example (window/scrolling scenario)
// The following example illustrates the use of decorators
// using the window/scrolling scenario.
// source https://en.wikipedia.org/wiki/Decorator_pattern#Java

//step1
// The Window interface class
abstract class IWindow {
  void draw(); // Draws the Window
  String get getDescription; // returns a description of the Window
}

// step 2
// Implementation of a simple Window without any scrollbars
class SimpleWindow implements IWindow {
  @override
  void draw() => print("This is SimpleWindow Class Draw"); // Draw window

  @override
  String get getDescription => "simple window Description";
}

// step 3
// The decorator interface class
// abstract decorator class - note that it implements Window
abstract class WindowDecorator implements IWindow {
  final IWindow _windowToBeDecorated; // the Window being decorated

  WindowDecorator(IWindow windowToBeDecorated)
      : _windowToBeDecorated = windowToBeDecorated;

  @override
  void draw() => _windowToBeDecorated.draw(); //Delegation

  @override
  String get getDescription => _windowToBeDecorated.getDescription; //Delegation

}

// step 4
// The following classes contain the decorators for all Window classes,
// Step 4.1
// The first concrete decorator which adds vertical scrollbar functionality
class VerticalScrollBarDecorator extends WindowDecorator {
  VerticalScrollBarDecorator(IWindow windowToBeDecorated)
      : super(windowToBeDecorated);

  @override
  void draw() {
    super.draw();
    _drawVerticalScrollBar();
  }

  @override
  String get getDescription =>
      super.getDescription + ", including vertical scrollbars";

  // new functionality >> Draw the vertical scrollbar
  void _drawVerticalScrollBar() =>
      print("add >> vertical scrollbar functionality");
}

// Step 4.2\
// The second concrete decorator which adds horizontal scrollbar functionality
class HorizontalScrollBarDecorator extends WindowDecorator {
  HorizontalScrollBarDecorator(IWindow windowToBeDecorated)
      : super(windowToBeDecorated);

  @override
  void draw() {
    super.draw();
    _drawHorizontalScrollBar();
  }

  @override
  String get getDescription =>
      super.getDescription + ", including horizontal scrollbars";

  void _drawHorizontalScrollBar() =>
      print("add >> horizontal scrollbar functionality");
}

// Here's a test program that creates a Window instance which is fully decorated
//(i.e., with vertical and horizontal scrollbars),
// and prints its description:
void main(List<String> args) {
  // Create a decorated Window with horizontal and vertical scrollbars
  IWindow simpleWindowWithoutScrolling = SimpleWindow();
  IWindow decoratedWindow = HorizontalScrollBarDecorator(
      VerticalScrollBarDecorator(simpleWindowWithoutScrolling));

  // Print the Window's description
  print(decoratedWindow.getDescription);
}

// The output of this program is
// "simple window Description, including vertical scrollbars, including horizontal scrollbars".

// Notice how the getDescription method of the two decorators
// first retrieve the decorated Window's description
// and decorates it with a suffix.
