// more_important_patterns/delegate/examples/f.dart
// ===============================================================
// Delegate Design Pattern Example in Pure Dart
// ===============================================================
//
// Scenario:
// We have a text document.
//
// The text document should be able to:
// 1. Check spelling.
// 2. Save itself as text.
// 3. Save itself as PDF.
//
// But the text document should NOT know how to do all these things.
// It should only delegate these tasks to specialized delegate objects.
//
// This keeps the TextDocumentDelegator focused on its main job:
// holding and managing text data.
//
// ===============================================================

// ===============================================================
// 1. Spell Check Delegate Interface
// ===============================================================
//
// This is the delegate contract.
//
// Any class that wants to become a spell-check delegate
// must implement this interface.
//
// The TextDocumentDelegator does not care which spell checker is used.
// It only knows that the delegate must provide this method:
//
// performSpellCheck(String text)
//
abstract class SpellCheckDelegate {
  List<String> performSpellCheck(String text);
}

// ===============================================================
// 2. Basic Spell Check Delegate
// ===============================================================
//
// This is a simple delegate implementation.
//
// It knows how to check normal/basic words only.
//
class BasicSpellCheckDelegate implements SpellCheckDelegate {
  final Set<String> _dictionary = {
    'hello',
    'this',
    'is',
    'a',
    'simple',
    'text',
    'dart',
    'code',
    'chat',
  };

  @override
  List<String> performSpellCheck(String text) {
    final words = _extractWords(text);

    final wrongWords = words.where((word) {
      return !_dictionary.contains(word);
    }).toList();

    return wrongWords;
  }

  List<String> _extractWords(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z\s]'), '')
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();
  }
}

// ===============================================================
// 3. Advanced Spell Check Delegate
// ===============================================================
//
// This is another delegate implementation.
//
// It supports extra internet/chat words like:
// lol, brb, omg, btw
//
// Because it implements the same SpellCheckDelegate interface,
// we can replace BasicSpellCheckDelegate with this one at runtime.
//
class AdvancedSpellCheckDelegate implements SpellCheckDelegate {
  final Set<String> _dictionary = {
    'hello',
    'this',
    'is',
    'a',
    'simple',
    'text',
    'dart',
    'code',
    'chat',
    'lol',
    'brb',
    'omg',
    'btw',
  };

  @override
  List<String> performSpellCheck(String text) {
    final words = _extractWords(text);

    final wrongWords = words.where((word) {
      return !_dictionary.contains(word);
    }).toList();

    return wrongWords;
  }

  List<String> _extractWords(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z\s]'), '')
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();
  }
}

// ===============================================================
// 4. Storage Delegate Interface
// ===============================================================
//
// This is another delegate contract.
//
// Any class that wants to handle saving must implement this interface.
//
// The TextDocumentDelegator does not know how saving works.
// It only asks its storage delegate to save the document.
//
abstract class StorageDelegate {
  void saveAsText(String location, TextDocumentDelegator document);

  void saveAsPdf(String location, TextDocumentDelegator document);
}

// ===============================================================
// 5. Console Storage Delegate
// ===============================================================
//
// This delegate simulates saving the document.
//
// In a real app, this class could save to:
// - local file
// - database
// - cloud storage
// - server API
//
// The TextDocumentDelegator does not need to change if we change
// the saving mechanism later.
//
class ConsoleStorageDelegate implements StorageDelegate {
  @override
  void saveAsText(String location, TextDocumentDelegator document) {
    print('Saving document as TEXT...');
    print('Location: $location');
    print('Content: ${document.text}');
  }

  @override
  void saveAsPdf(String location, TextDocumentDelegator document) {
    print('Saving document as PDF...');
    print('Location: $location');
    print('Content: ${document.text}');
  }
}

// ===============================================================
// 6. Text Document Delegator
// ===============================================================
//
// This is the Delegator.
//
// The delegator receives requests from the outside world.
//
// Example requests:
// - "Check spelling"
// - "Save as text"
// - "Save as PDF"
//
// But instead of doing everything itself,
// it delegates the work to specialized delegate objects:
//
// - SpellCheckDelegate
// - StorageDelegate
//
// This is the core idea of the Delegate Design Pattern.
//
class TextDocumentDelegator {
  String _text;

  SpellCheckDelegate _spellCheckDelegate;
  StorageDelegate _storageDelegate;

  TextDocumentDelegator(
    this._text, {
    required SpellCheckDelegate spellCheckDelegate,
    required StorageDelegate storageDelegate,
  })  : _spellCheckDelegate = spellCheckDelegate,
        _storageDelegate = storageDelegate;

  String get text => _text;

  void updateText(String newText) {
    _text = newText;
  }

  void setSpellCheckDelegate(SpellCheckDelegate delegate) {
    _spellCheckDelegate = delegate;
  }

  void setStorageDelegate(StorageDelegate delegate) {
    _storageDelegate = delegate;
  }

  List<String> requestSpellCheck() {
    print('TextDocumentDelegator: Spell check requested.');
    print('TextDocumentDelegator: Delegating spell check work...');

    return _spellCheckDelegate.performSpellCheck(_text);
  }

  void requestSaveAsText(String location) {
    print('TextDocumentDelegator: Save as text requested.');
    print('TextDocumentDelegator: Delegating save text work...');

    _storageDelegate.saveAsText(location, this);
  }

  void requestSaveAsPdf(String location) {
    print('TextDocumentDelegator: Save as PDF requested.');
    print('TextDocumentDelegator: Delegating save PDF work...');

    _storageDelegate.saveAsPdf(location, this);
  }
}

// ===============================================================
// 7. Main Program
// ===============================================================
//
// Here we create the delegator and assign delegates to it.
//
void main() {
  final document = TextDocumentDelegator(
    'Hello wrld this is a chat lol brb',
    spellCheckDelegate: BasicSpellCheckDelegate(),
    storageDelegate: ConsoleStorageDelegate(),
  );

  print('--- Using Basic Spell Check Delegate ---');
  final basicErrors = document.requestSpellCheck();
  print('Wrong words: $basicErrors');

  print('\n--- Changing Delegate at Runtime ---');
  document.setSpellCheckDelegate(AdvancedSpellCheckDelegate());

  print('\n--- Using Advanced Spell Check Delegate ---');
  final advancedErrors = document.requestSpellCheck();
  print('Wrong words: $advancedErrors');

  print('\n--- Saving Document ---');
  document.requestSaveAsText('/documents/my-document.txt');

  print('\n--- Saving PDF ---');
  document.requestSaveAsPdf('/documents/my-document.pdf');
}
