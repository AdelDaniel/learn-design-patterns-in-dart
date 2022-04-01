//**
// Base factory class.
// Note that "factory" is merely a role for the class.
// should have some core business logic which needs different products to be
// created.
// */

//!  Demo main(). Everything comes together here.

import 'dialog.dart';

enum SystemType { Windows, Html }
void main() {
  IDialog dialog = configure(SystemType.Windows);
  runBusinessLogic(dialog);
}

IDialog configure(SystemType systemType) {
  IDialog dialog;
  if (systemType == SystemType.Windows) {
    dialog = new WindowsDialog();
  } else {
    dialog = new HtmlDialog();
  }
  return dialog;
}

void runBusinessLogic(IDialog dialog) {
  dialog.renderOnScreen();
}
