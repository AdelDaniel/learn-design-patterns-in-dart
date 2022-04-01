//!Common  abstract class for all buttons.
abstract class IButton {
  void render();
  void onClick();
}

//! HTML button implementation.
class HtmlButton implements IButton {
  void render() {
    print("<button>HTML Test Button</button>");
    onClick();
  }

  void onClick() => print("HTML Button >> Clicked!");
}

// ! Windows button implementation.
class WindowsButton implements IButton {
  void render() {
    print("Windows Test Button");
    onClick();
  }

  void onClick() => print("Windows Button >> Clicked!");
}
