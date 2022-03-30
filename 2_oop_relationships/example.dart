class Product {
  int _id;
  String _name;
  String _description;

  Product(int id, String name, String description)
      : _id = id,
        _name = name,
        _description = description;

  @override
  String toString() =>
      "Product [id= $_id   name= $_name , description=  $_description  ]";
}

// Step 2: This is CartItem class,
// which HAS-A aggregation associated with the Product class.
class CartItem {
  int _id;
  int _quantity;
  Product _product;

  CartItem(int id, int quantity, Product p)
      : _id = id,
        _quantity = quantity,
        _product = p;
  int get id => _id;
  @override
  String toString() =>
      "CartItem [id= $_id  , quantity= $_quantity   product=  $_product  ]";
}

// Step 3: This is the Order class,
// which HAS-A composition association with CartItem class.
// That means if you delete Order,
// then associated all CartItem must be deleted.
class Order {
  final int _id;
  final String _name;
  final List<CartItem> _CartItems;

  Order(int id, String name)
      : _id = id,
        _name = name,
        _CartItems = <CartItem>[];

  @override
  String toString() =>
      "Order [id= $_id   name=$_name  CartItems= $_CartItems ]";

  // Add line item to order
  void addItem(int id, int quantity, Product p) {
    _CartItems.add(CartItem(id, quantity, p));
  }

  // Remove line item from order for given item id
  void removeItemById(int itemId) {
    _CartItems.removeWhere((listItem) => listItem.id == itemId);
  }
}

// Step 4: Let's write a test
void main() {
  // Create Products
  Product p1 = new Product(1, "Pen", "This is red pen");
  Product p2 = new Product(2, "Pencil", "This is pencil");
  Product p3 = new Product(3, "ColorBox", "This is color box");
  List<Product> products = [p1, p2, p3];
  implementAggregation(products);
  implementComposition(products);
}

void implementAggregation(List<Product> products) {
// Create CartItem and add quntity of the products
  CartItem? item1 = new CartItem(1, 2, products[1]);
  CartItem? item2 = new CartItem(1, 2, products[0]);

  // Before deleting line item 1
  print(item1.id);
  print(item1.toString());
  print(item2.toString());
  item1 = null;

  // Still product exist and not deleted
  print(products[1]);
}

void implementComposition(List<Product> products) {
  // Create Order and Add Line Items
  Order? o = new Order(1, "ORD#1");
  o.addItem(1, 2, products[0]); // Ordered of 2 quantity for p1 product
  o.addItem(2, 1, products[1]); // Ordered of 1 quantity for p2 product
  o.addItem(3, 5, products[2]); // Ordered of 5 quantity for p3 product
  // Print Order detail before deleting
  print("Order ---");
  print(o);
  // Deleting order would also delete associated CartItems
  o = null;
}
