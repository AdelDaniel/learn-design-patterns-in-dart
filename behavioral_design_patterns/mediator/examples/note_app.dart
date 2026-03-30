// behavioral_design_patterns/mediator/examples/note_app.dart
// https://refactoring.guru/design-patterns/mediator/java/example#example-0--OutputDemo-png
// Usage examples:
// The most popular usage of the Mediator pattern in Java code is facilitating communications between GUI components of an app.
// The synonym of the Mediator is the Controller part of MVC pattern.

// Notes app
// This example shows how to organize lots of UI elements so that they cooperate with the help of a mediator but don’t depend on each other.

// ----------------------------------------------------------------------------
// Model
// ----------------------------------------------------------------------------

/// A simple data class representing a Note.
class Note {
  String name;
  String text;

  Note({this.name = 'New note', this.text = ''});

  @override
  String toString() => name;
}

// ----------------------------------------------------------------------------
// Interfaces
// ----------------------------------------------------------------------------

/// The Mediator interface declares methods used by components to notify the mediator about various events. 
/// The Mediator may react to these events
/// and pass the execution to other components.
abstract interface class Mediator {
  void addNewNote(Note note);
  void deleteNote();
  void getInfoFromList(Note note);
  void saveChanges();
  void markNote();
  void clear();
  void sendToFilter(List<Note> notes);
  void setElementsList(List<Note> notes);
  void registerComponent(Component component);
  void hideElements(bool flag);
}

/// The Base Component interface provides the basic functionality of storing
/// a mediator's instance inside component objects.
abstract interface class Component {
  String getName();
}

// ----------------------------------------------------------------------------
// Concrete Components
// ----------------------------------------------------------------------------

/// Concrete Components don't talk to each other. They have only one
/// communication channel – sending requests to the mediator.

class AddButton implements Component {
  final Mediator _mediator;
  const AddButton(this._mediator);

  @override
  String getName() => "AddButton";

  void press() {
    print("AddButton: Clicked.");
    _mediator.addNewNote(Note());
  }
}

class DeleteButton implements Component {
  final Mediator _mediator;
  const DeleteButton(this._mediator);

  @override
  String getName() => "DelButton";

  void press() {
    print("DeleteButton: Clicked.");
    _mediator.deleteNote();
  }
}

class SaveButton implements Component {
  final Mediator _mediator;
  const SaveButton(this._mediator);

  @override
  String getName() => "SaveButton";

  void press() {
    print("SaveButton: Clicked.");
    _mediator.saveChanges();
  }
}

class Filter implements Component {
  final Mediator _mediator;
  List<Note> _originalList = [];
  Filter(this._mediator);

  @override
  String getName() => "Filter";

  void setList(List<Note> list) {
    _originalList = list;
  }

  void search(String query) {
    print("Filter: Searching for '$query'");
    if (query.isEmpty) {
      _mediator.setElementsList(_originalList);
      return;
    }

    final filtered =
        _originalList.where((note) => note.name.contains(query)).toList();

    _mediator.setElementsList(filtered);
  }
}

class NoteList implements Component {
  final Mediator _mediator;
  final List<Note> _notes = [];
  NoteList(this._mediator);

  Note? _selectedNote;

  @override
  String getName() => "List";

  int getCount() => _notes.length;

  Note? getSelectedNote() => _selectedNote;

  void setElements(List<Note> notes) {
    if (!identical(_notes, notes)) {
      _notes.clear();
      _notes.addAll(notes);
    }
    if (_selectedNote != null && !_notes.contains(_selectedNote)) {
      _selectedNote = null;
    }
    print("NoteList: Updated list content: ${_notes.join(', ')}");
  }

  void repaint() {
    print("NoteList: Repainted list content: ${_notes.join(', ')}");
  }

  void addElement(Note note) {
    _notes.add(note);
    selectElement(note); // Select the new note automatically
    _mediator.sendToFilter(List.from(_notes));
  }

  void deleteElement() {
    if (_selectedNote != null) {
      _notes.remove(_selectedNote);
      if (_notes.isEmpty) {
        _selectedNote = null;
        // Notify mediator that selection is empty to hide edit controls
        _mediator.hideElements(true);
      } else {
        // Select the last one for simplicity
        selectElement(_notes.last);
      }
      _mediator.sendToFilter(List.from(_notes));
    }
  }

  void selectElement(Note note) {
    if (_notes.contains(note)) {
      _selectedNote = note;
      print("NoteList: Selected note '${note.name}'");
      _mediator.getInfoFromList(note);
      _mediator.hideElements(false);
    }
  }
}

class Title implements Component {
  final Mediator _mediator;
  String _text = "";
  Title(this._mediator);

  @override
  String getName() => "Title";

  void setText(String text) {
    _text = text;
    print("Title: Set text to '$_text'");
  }

  String getText() => _text;

  // Simulate user typing
  void enterText(String text) {
    _text = text;
    _mediator.markNote(); // Mark as modified
  }
}

class TextBox implements Component {
  final Mediator _mediator;
  String _text = "";
  TextBox(this._mediator);

  @override
  String getName() => "TextBox";

  void setText(String text) {
    _text = text;
    print("TextBox: Set text to '$_text'");
  }

  String getText() => _text;

  // Simulate user typing
  void enterText(String text) {
    _text = text;
    _mediator.markNote(); // Mark as modified
  }
}

// ----------------------------------------------------------------------------
// Mediator Implementation
// ----------------------------------------------------------------------------

/// Concrete Mediator. All chaotic communications between concrete components
/// have been extracted to the mediator. Now components only talk with the
/// mediator, which knows who has to handle a request.
class Editor implements Mediator {
  late Title _title;
  late TextBox _textBox;
  late AddButton _add;
  late DeleteButton _del;
  late SaveButton _save;
  late NoteList _list;
  late Filter _filter;

  @override
  void registerComponent(Component component) {
    switch (component.getName()) {
      case "AddButton":
        _add = component as AddButton;
        break;
      case "DelButton":
        _del = component as DeleteButton;
        break;
      case "Filter":
        _filter = component as Filter;
        break;
      case "List":
        _list = component as NoteList;
        break;
      case "SaveButton":
        _save = component as SaveButton;
        break;
      case "TextBox":
        _textBox = component as TextBox;
        break;
      case "Title":
        _title = component as Title;
        break;
    }
  }

  @override
  void addNewNote(Note note) {
    _title.setText("");
    _textBox.setText("");
    _list.addElement(note);
  }

  @override
  void deleteNote() {
    _list.deleteElement();
  }

  @override
  void getInfoFromList(Note note) {
    _title.setText(note.name.replaceAll('*', ''));
    _textBox.setText(note.text);
  }

  @override
  void saveChanges() {
    final note = _list.getSelectedNote();
    if (note != null) {
      note.name = _title.getText();
      note.text = _textBox.getText();
      print("Editor: Saved changes to note '${note.name}'");
      // Force list update to reflect name change if needed
      _list.setElements(_list._notes);
    }
  }

  @override
  void markNote() {
    final note = _list.getSelectedNote();
    if (note != null) {
      String name = note.name;
      if (!name.endsWith("*")) {
        note.name = name + "*";
        print("Editor: Marked note as modified: ${note.name}");
      }
    }
  }

  @override
  void clear() {
    _title.setText("");
    _textBox.setText("");
    print("Editor: Cleared title and text fields.");
  }

  @override
  void sendToFilter(List<Note> notes) {
    _filter.setList(notes);
  }

  @override
  void setElementsList(List<Note> notes) {
    _list.setElements(notes);
  }

  @override
  void hideElements(bool flag) {
    if (flag) {
      print("Editor: Hiding editing area (No selection).");
    } else {
      print("Editor: Showing editing area.");
    }
  }
}

// ----------------------------------------------------------------------------
// Execution
// ----------------------------------------------------------------------------

void main() {
  final mediator = Editor();

  final addBtn = AddButton(mediator);
  final delBtn = DeleteButton(mediator);
  final saveBtn = SaveButton(mediator);
  final filter = Filter(mediator);
  final list = NoteList(mediator);
  final title = Title(mediator);
  final textBox = TextBox(mediator);

  mediator.registerComponent(addBtn);
  mediator.registerComponent(delBtn);
  mediator.registerComponent(saveBtn);
  mediator.registerComponent(filter);
  mediator.registerComponent(list);
  mediator.registerComponent(title);
  mediator.registerComponent(textBox);

  print("\n--- User Action: Add Note ---");
  addBtn.press();

  print("\n--- User Action: Edit Note ---");
  title.enterText("My First Note");
  textBox.enterText("This is the content of the note.");

  print("\n--- User Action: Save Note ---");
  saveBtn.press();

  print("\n--- User Action: Add Another Note ---");
  addBtn.press();
  title.enterText("Shopping List");
  saveBtn.press();

  print("\n--- User Action: Filter 'First' ---");
  filter.search("First");

  print("\n--- User Action: Filter 'Shopping' ---");
  filter.search("Shopping");

  print("\n--- User Action: Filter Clear (Show all) ---");
  filter.search("");

  print("\n--- User Action: Delete Selected Note ---");
  delBtn.press();
}
