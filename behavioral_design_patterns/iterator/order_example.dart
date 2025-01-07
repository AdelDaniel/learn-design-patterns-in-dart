// https://refactoring.guru/design-patterns/iterator/swift/example#example-1

enum IterationType { inOrder, preOrder, postOrder }

class Tree<T> {
  T value;
  Tree<T>? left;
  Tree<T>? right;

  Tree(this.value);

  List<T> iterator(IterationType type) {
    List<T> items = [];
    switch (type) {
      case IterationType.inOrder:
        inOrder(items.add);
      case IterationType.preOrder:
        preOrder(items.add);
      case IterationType.postOrder:
        postOrder(items.add);
    }

    /// Note:
    /// AnyIterator is used to hide the type signature of an internal iterator.
    return List.from(items);
  }

  void inOrder(void Function(T) body) {
    left?.inOrder(body);
    body(value);
    right?.inOrder(body);
  }

  void preOrder(void Function(T) body) {
    body(value);
    left?.inOrder(body);
    right?.inOrder(body);
  }

  void postOrder(void Function(T) body) {
    left?.inOrder(body);
    right?.inOrder(body);
    body(value);
  }
}

void main(List<String> args) {
  final tree = Tree(1);
  tree.left = Tree(2);
  tree.right = Tree(3);

  print("Tree traversal: In-order");
  clientCode(iterator: tree.iterator(IterationType.inOrder));

  print("\nTree traversal: Pre-order");
  clientCode(iterator: tree.iterator(IterationType.preOrder));

  print("\nTree traversal: Post-order");
  clientCode(iterator: tree.iterator(IterationType.postOrder));
}

void clientCode<T>({required List<T> iterator}) {
  for (var item in iterator) {
    print(item);
  }
}
