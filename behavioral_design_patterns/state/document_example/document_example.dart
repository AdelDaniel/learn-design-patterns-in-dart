import 'dart:io';

/// Roles
/// Can render only is published
///
/// Hints:
/// Action is take on the context [document] based on the state of the document.
/// Then before go to next state check the current state and action on it

/// Interface class
abstract interface class DocumentState {
  /// Context
  final Document document;

  const DocumentState({required this.document});

  /// View or Render
  void render();

  /// Publish to the store
  void publish();

  /// Edit
  void edit();
}

class DraftState extends DocumentState {
  const DraftState({required super.document});

  @override
  void render() {
    print("DraftState: render is invoked");
    if (document.user == UserType.admin || document.user == UserType.editor) {
      print("DraftState: rendering the draft content...");
      document.showContent();
    } else {
      print("DraftState: Cannot render draft content for non-admin users");
    }
  }

  @override
  void publish() {
    print("DraftState: publish is invoked");
    if (document.user == UserType.admin) {
      document.setState(PublishedState(document: document));
      document.state.publish();
    } else {
      print("DraftState: Cannot publish draft content for non-admin users");
    }
  }

  @override
  void edit() {
    print("DraftState: Editing is invoked");

    if (document.user == UserType.admin || document.user == UserType.editor) {
      document.setState(EditingState(document: document));
      document.state.edit();
    } else {
      print("DraftState: Cannot Editing draft content");
    }
  }
}

class PublishedState extends DocumentState {
  const PublishedState({required super.document});

  @override
  void render() {
    print("PublishedState: render is invoked");
    print("PublishedState: rendering the published content...");
    document.showContent();
  }

  @override
  void publish() {
    print("PublishedState: publish is invoked");
    if (document.user == UserType.admin) {
      print("PublishedState: published....");
    } else {
      print("PublishedState: Cannot Publish..");
    }
  }

  @override
  void edit() {
    print("PublishedState: editing is invoked");
    print("PublishedState: Cannot edit published content");
  }
}

class EditingState extends DocumentState {
  const EditingState({required super.document});

  @override
  void render() {
    print("EditingState: render is invoked");
    if (document.user == UserType.admin || document.user == UserType.editor) {
      print("EditingState: rendering the editing content...");
      document.showContent();
    } else {
      print("EditingState: Cannot render editing content for non-admin users");
    }
  }

  @override
  void publish() {
    print("EditingState: publish is invoked");
    if (document.user == UserType.editor || document.user == UserType.admin) {
      print("EditingState: sending the content for moderation...");
      document.setState(PublishedState(document: document));
      document.state.publish();
    } else {
      print("EditingState: Cannot publish moderation content");
    }
  }

  @override
  void edit() {
    print("EditingState: editing is invoked");
    if (document.user == UserType.admin || document.user == UserType.editor) {
      print("EditingState: editing the content...");
      while (true) {
        print("\n");
        print("For exit: X ");
        final String? op = stdin.readLineSync()?.toLowerCase().trim();
        document.showContent();
        if (op?.contains('x') == true) {
          document.setState(DraftState(document: document));
          // document.state.render();
          break;
        } else {
          print("Enter new content: ");
          final String? newContent = stdin.readLineSync();
          document.updateContent(newContent ?? "");
        }
      }
    } else {
      print("EditingState: Cannot edit content for non-admin or editor users");
    }
  }
}

class Document {
  late DocumentState _state;
  UserType _user;
  String _content = "This is the content of the document";

  Document(this._user) {
    _state = DraftState(document: this);
  }

  void setState(DocumentState state) {
    print("setState: $state");
    _state = state;
  }

  void setUser(UserType user) {
    print("setUser: $user");
    _user = user;
  }

  DocumentState get state => _state;
  UserType get user => _user;

  void showContent() {
    print("Document: Showing the content of the document...");
    print("Content: $_content");
  }

  void updateContent(String content) {
    _content = content;
    print("New Content: $_content");
  }

  // void render() => _state.render();
  // void publish() => _state.publish();
  // void edit() => _state.edit();
}

void main() {
  Document document = Document(UserType.admin);

  while (true) {
    print("\n");
    print(
        "Enter Operation: render: 1 -- publish: 2 -- edit: 3 -- admin: 4 -- editor: 5 -- normal: 6 -- else: exit ");
    final String? op = stdin.readLineSync()?.toLowerCase().trim();

    if (op?.contains('1') == true) {
      document.state.render();
    } else if (op?.contains('2') == true) {
      document.state.publish();
    } else if (op?.contains('3') == true) {
      document.state.edit();
    } else if (op?.contains('4') == true) {
      document.setUser(UserType.admin);
    } else if (op?.contains('5') == true) {
      document.setUser(UserType.editor);
    } else if (op?.contains('6') == true) {
      document.setUser(UserType.viewer);
    } else {
      print("Invalid operation. Please try again.");
      break;
    }
  }

  // document.render();
  // document.publish();

  // document.setState(PublishedState());
  // document.render();
  // document.publish();

  // document.setState(EditingState());
  // document.render();
  // document.publish();
}

enum UserType { admin, editor, viewer }

/// Old
/*
class Document {
  late String _state;

  Document() {
    _state = "draft";
  }

  void publish() {
    switch (_state) {
      case "draft":
        _moveToModeration();
        break;
      case "moderation":
        _approveForPublication();
        break;
      case "published":
        break;
    }
  }

  void _moveToModeration() {
    _state = "moderation";
    print("Document moved to moderation status.");
  }

  void _approveForPublication() {
    _state = "published";
    print("Document approved for publishable status.");
  }
}
*/
