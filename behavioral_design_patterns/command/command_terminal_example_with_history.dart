import 'dart:io';

/// Usage examples: The Command pattern is pretty common in Java code.
/// Most often it’s used as an alternative for callbacks to parameterizing UI elements with actions.
/// It’s also used for queueing tasks, tracking operations history, etc.

/// Identification: If you see a set of related classes that represent specific actions
/// (such as “Copy”, “Cut”, “Send”, “Print”, etc.),
/// this may be a Command pattern.
/// These classes should implement the same interface/abstract class.
/// The commands may implement the relevant actions on their own or delegate the work to separate objects—that will be the receivers.
/// The last piece of the puzzle is to identify an invoker—search for a class that accepts the command objects in the parameters of its methods or constructor.

/// Text editor commands and undo
/// The text editor in this example creates new command objects each time a user interacts with it.
/// After executing its actions, a command is pushed to the history stack.

/// Now, to perform the undo operation,
/// the application takes the last executed command from the history and either performs an inverse action or restores the past state of the editor,
/// saved by that command.

/// Commands
/// The base command class defines the common interface for all
/// concrete commands.
abstract class Command {
  final Editor editor;
  String? _backup;

  Command(this.editor);

  /// Make a backup of the editor's state.
  void backup() => _backup = editor.text;

  /// Restore the editor's state.
  void undo() {
    if (_backup != null) {
      editor.text = _backup!;
    }
  }

  /// The execution method is declared abstract to force all
  /// concrete commands to provide their own implementations.
  /// The method must return true or false depending on whether
  /// the command changes the editor's state.
  bool execute();
}

/// CopyCommand: Copy selected text to clipboard
class CopyCommand extends Command {
  CopyCommand(super.editor);

  @override
  bool execute() {
    editor.clipboard = editor.text;
    return false;
  }
}

/// CutCommand: Cut selected text to clipboard
class CutCommand extends Command {
  CutCommand(super.editor);

  /// The cut command does change the editor's state, therefore
  /// it must be saved to the history. And it'll be saved as
  /// long as the method returns true.
  @override
  bool execute() {
    backup();
    editor.clipboard = editor.text;
    editor.text = "";
    return true;
  }
}

/// PasteCommand: Paste text from clipboard
class PasteCommand extends Command {
  PasteCommand(super.editor);

  @override
  bool execute() {
    if (editor.clipboard.isEmpty) {
      return false;
    }

    backup();
    editor.text = editor.clipboard + " " + editor.text;
    return true;
  }
}

/// CommandHistory: Command history
class CommandHistory {
  final List<Command> _historyStack = [];

  void push(Command command) => _historyStack.add(command);

  Command pop() => _historyStack.removeLast();

  bool isEmpty() => _historyStack.isEmpty;
}

/// Editor is the receiver
class Editor {
  String text = "";
  String clipboard = "";
  Editor({required this.text});
}

// The application class sets up object relations. It acts as a
// sender: when something needs to be done, it creates a command
// object and executes it.
class Application {
  final Editor editor;
  CommandHistory _history = CommandHistory();
  Application({required this.editor});

  /// Execute a command and check whether it has to be added to
  /// the history.
  void executeCommand(command) {
    if (command.execute()) {
      _history.push(command);
    }
  }

  /// print text and clipboard
  void printState() {
    print("text: ${editor.text}");
    print("clipboard: ${editor.clipboard}");
  }

  // Take the most recent command from the history and run its
  // undo method. Note that we don't know the class of that
  // command. But we don't have to, since the command knows
  // how to undo its own action.
  void undo() {
    try {
      Command command = _history.pop();
      command.undo();
    } catch (e) {
      print(e);
    }
  }
}

/// Client code

void main(List<String> args) {
  /// Reading name of the Geek
  print("Enter Text To Edit: ");
  final String? text = stdin.readLineSync();

  /// Receiver
  final Editor editor = Editor(text: text ?? "");

  /// Invoker (Sender)
  final Application application = Application(editor: editor);

  /// Commands
  CopyCommand copyCommand = CopyCommand(editor);
  CutCommand cutCommand = CutCommand(editor);
  PasteCommand pasteCommand = PasteCommand(editor);

  while (true) {
    print(
      "Enter Operation: copy: ^Co \t copy: ^Cu \t paste: ^Pa \t paste: ^Pr \t undo: ^U",
    );
    final String? op = stdin.readLineSync()?.toLowerCase().trim();

    print("\n");
    if (op?.contains('co') == true) {
      application.executeCommand(copyCommand);
    } else if (op?.contains('cu') == true) {
      application.executeCommand(cutCommand);
    } else if (op?.contains('pa') == true) {
      application.executeCommand(pasteCommand);
    } else if (op?.contains('pr') == true) {
      application.printState();
    } else if (op?.contains('u') == true) {
      application.undo();
    } else {
      print("---- not exist ----");
    }
    print("\n");
  }
}
