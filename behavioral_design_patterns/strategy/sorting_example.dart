abstract interface class SortStrategy {
  List<int> sort(List<int> list);
}

class BubbleSortStrategy implements SortStrategy {
  @override
  List<int> sort(List<int> list) {
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list.length - i - 1; j++) {
        if (list[j] > list[j + 1]) {
          int temp = list[j];
          list[j] = list[j + 1];
          list[j + 1] = temp;
        }
      }
    }
    return list;
  }
}

class SelectionSortStrategy implements SortStrategy {
  @override
  List<int> sort(List<int> list) {
    for (int i = 0; i < list.length - 1; i++) {
      int minIndex = i;
      for (int j = i + 1; j < list.length; j++) {
        if (list[j] < list[minIndex]) {
          minIndex = j;
        }
      }
      int temp = list[minIndex];
      list[minIndex] = list[i];
      list[i] = temp;
    }
    return list;
  }
}

class SortContext {
  SortStrategy _sortStrategy;

  SortContext(SortStrategy sortStrategy) : _sortStrategy = sortStrategy;

  void changeStrategy(SortStrategy sortStrategy) =>
      _sortStrategy = sortStrategy;

  List<int> sort(List<int> list) {
    return _sortStrategy.sort(list);
  }
}

void main() {
  // Create SortContext with BubbleSortStrategy
  SortContext sortContext = SortContext(BubbleSortStrategy());
  List<int> list1 = [5, 2, 9, 1, 5];
  sortContext.sort(list1);

  // Change strategy to MergeSortStrategy
  sortContext.changeStrategy(SelectionSortStrategy());
  List<int> list2 = [8, 3, 7, 4, 2];
  sortContext.sort(list2);
}
