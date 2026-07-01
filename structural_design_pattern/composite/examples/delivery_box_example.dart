// structural_design_pattern/composite/examples/delivery_box_example.dart
// The Composite Design Pattern is a structural pattern that lets you compose
// objects into tree structures and work with them as if they were individual objects.
//
// In this real-life delivery packaging example:
// - [CatalogItem] is the Component interface.
// - [Product] is the Leaf (a single item with a fixed price).
// - [Box] is the Composite (can contain products or other smaller boxes; calculates total price recursively).

// 1. Component
abstract interface class CatalogItem {
  String get name;
  double getPrice();
}

// 2. Leaf
class Product implements CatalogItem {
  @override
  final String name;
  final double price;

  Product(this.name, this.price);

  @override
  double getPrice() => price;
}

// 3. Composite
class Box implements CatalogItem {
  @override
  final String name;
  final List<CatalogItem> _items = [];

  Box(this.name);

  void add(CatalogItem item) => _items.add(item);

  void remove(CatalogItem item) => _items.remove(item);

  List<CatalogItem> get items => List.unmodifiable(_items);

  @override
  double getPrice() {
    double total = 0.0;
    for (var item in _items) {
      total += item.getPrice();
    }
    return total;
  }
}

// 4. Client
void main() {
  // Create single products (Leaves)
  final charger = Product('USB-C Charger', 29.99);
  final screenProtector = Product('Screen Protector', 15.00);
  final phone = Product('iPhone 15', 999.99);
  final headphones = Product('AirPods Pro', 249.99);

  // Package them into boxes (Composites)
  final accessoriesBox = Box('Accessories Box');
  accessoriesBox.add(charger);
  accessoriesBox.add(screenProtector);

  final mainDeliveryBox = Box('Main Delivery Box');
  mainDeliveryBox.add(phone);
  mainDeliveryBox.add(headphones);

  // Nesting a Box inside another Box (Composite inside Composite)
  mainDeliveryBox.add(accessoriesBox);

  // The client can query any CatalogItem (either product or composite box) for its price
  print('--- Pricing Details ---');
  print('${phone.name} Price: \$${phone.getPrice()}');
  print('${accessoriesBox.name} Total Price: \$${accessoriesBox.getPrice()}');
  print('${mainDeliveryBox.name} Total Price: \$${mainDeliveryBox.getPrice()}');
}
