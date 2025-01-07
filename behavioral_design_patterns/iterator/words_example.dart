// https://refactoring.guru/design-patterns/iterator/swift/example#example-0

/// This example illustrates the structure of the Iterator design pattern
/// and focuses on the following questions:
///
/// What classes does it consist of?
/// What roles do these classes play?
/// In what way the elements of the pattern are related?
///
///
/// After learning about the pattern’s structure it’ll be easier for you to grasp the following example,
///
/// based on a real-world Swift use case.
library;

/// This is a collection that we're going to iterate through using an iterator
/// derived from IteratorProtocol.

abstract interface class Collection<T> {
  final List<T> items = [];
  void append(T item);
  Iterator<T> makeIterator();
}

abstract interface class Iterator<T> {
  const Iterator();
  T? next();
}

class WordsCollection implements Collection<String> {
  @override
  final List<String> items = [];

  @override
  void append(String item) {
    items.add(item);
  }

  @override
  WordsIterator makeIterator() {
    return WordsIterator(this);
  }
}

/// Concrete Iterators implement various traversal algorithms. These classes
/// store the current traversal position at all times.
class WordsIterator implements Iterator<String> {
  final WordsCollection collection;
  int index = 0;

  WordsIterator(this.collection);

  @override
  String? next() {
    index += 1;
    return index < collection.items.length ? collection.items[index] : null;
  }
}

/// Client does not know the internal representation of a given sequence.
class Client {
  static void clientCode({required Collection collection}) {
    for (final item in collection.items) {
      print(item);
    }
  }
}

/// Let's see how it all works together.
void main() {
  final words = WordsCollection();
  words.append("First");
  words.append("Second");
  words.append("Third");

  print("Straight traversal using IteratorProtocol:");
  Client.clientCode(collection: words);
}

// Output:
// Execution result
// Straight traversal using IteratorProtocol:
// First
// Second
// Third
