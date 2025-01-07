/// Iterator pattern is very commonly used design pattern in Java and .Net programming environment.
/// This pattern is used to get a way to access the elements of a collection object in sequential manner without any need to know its underlying representation.
library;

/// Implementation
/// We're going to create a Iterator interface which narrates navigation method and a Container interface which returns the iterator.
/// Concrete classes implementing the Container interface will be responsible to implement Iterator interface and use it

/// Step 1: Create interfaces.
abstract interface class Iterator<T> {
  bool hasNext();
  T? next();
}

abstract interface class Container<T> {
  Iterator getIterator();
}

/// Step 2: Create concrete class implementing the Container interface.
/// This class has inner class NameIterator implementing the Iterator interface.
class NameRepository implements Container {
  @override
  Iterator getIterator() {
    return NameIterator();
  }
}

class NameIterator implements Iterator {
  List<String> names = ["Robert", "John", "Julie", "Lora"];

  int index = 0;

  @override
  bool hasNext() {
    if (index < names.length) {
      return true;
    }
    return false;
  }

  @override
  Object? next() {
    if (hasNext()) {
      return names[index++];
    }
    return null;
  }
}

/// Step 3: Use the NameRepository to get iterator and print names.

void main() {
  NameRepository namesRepository = NameRepository();

  for (Iterator iter = namesRepository.getIterator(); iter.hasNext();) {
    String name = iter.next();
    print("Name : $name");
  }
}


/// Step 4: Verify the output.

/// Name : Robert
/// Name : John
/// Name : Julie
/// Name : Lora
