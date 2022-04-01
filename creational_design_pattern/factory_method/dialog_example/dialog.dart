import 'buttons.dart';

abstract class IDialog {
  void renderOnScreen() {
    // ... other code ...
    IButton okButton = createButton();
    okButton.render();
  }

  // Subclasses will override this method in order to create specific button objects.
  IButton createButton();
}

//!  HTML Dialog will produce HTML buttons.
class HtmlDialog extends IDialog {
  @override
  IButton createButton() => HtmlButton();
}

//!  Windows Dialog will produce Windows buttons.
class WindowsDialog extends IDialog {
  @override
  IButton createButton() => WindowsButton();
}
