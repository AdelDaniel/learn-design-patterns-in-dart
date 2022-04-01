// Example of Builder Design Pattern
// To create simple example of builder design pattern,
// >> you need to follow 6 following steps.

// Create Packing  abstract class
// Create 2 abstract classes CD and Company
// Create 2 implementation classes of Company: Sony and Samsung
// Create the CDType class
// Create the CDBuilder class
// Create the BuilderDemo class

//! 1) Create Packing  abstract class
abstract class Packing {
  String pack();
  int price();
}

// !2) Create 2 abstract classes CD and Company
// Create an abstract class CD which will implement Packing  abstract class.
abstract class CD implements Packing {
  String pack();
}

abstract class Company extends CD {
  int price();
}

//! 3) Create 2 implementation classes of Company: Sony and Samsung
class Sony extends Company {
  @override
  int price() => 20;

  @override
  String pack() => "Sony CD";
} //End of the Sony class.

class Samsung extends Company {
  @override
  int price() => 15;

  @override
  String pack() => "Samsung CD";
} //End of the Samsung class.

//! 4) Create the CDType class
class CDType {
  List<Packing> _items = <Packing>[];
  void addItem(Packing packs) => _items.add(packs);

  void getCost() {
    for (Packing packs in _items) {
      packs.price();
    }
  }

  void showItems() {
    for (Packing packing in _items) {
      print("CD name:  ${packing.pack()} && Price:  ${packing.price()}");
    }
  }
} //End of the CDType class.

//! 5) Create the CDBuilder class
class CDBuilder {
  CDType buildSonyCD() {
    CDType cds = new CDType();
    cds.addItem(new Sony());
    return cds;
  }

  CDType buildSamsungCD() {
    CDType cds = new CDType();
    cds.addItem(new Samsung());
    return cds;
  }
} // End of the CDBuilder class.

//! 6) Create the BuilderDemo Main Method
void main() {
  CDBuilder cdBuilder = new CDBuilder();
  CDType cdType1 = cdBuilder.buildSonyCD();
  cdType1.showItems();

  CDType cdType2 = cdBuilder.buildSamsungCD();
  cdType2.showItems();
}

// Output of the above example
// CD name : Sony CD, Price : 20
// CD name : Samsung CD, Price : 15
