import 'package:shopping/models/product_model.dart';

class Cart {
  // Ensure the list is mutable by initializing it with a normal list
  List<Product> _products = [];

  // Getter for the cart products
  List<Product> get products => _products;

  // Method to add a product to the cart
  void addProduct(Product product) {
    _products.add(product);
  }

  // Method to remove a product from the cart
  void removeProduct(Product product) {
    _products.remove(product);
  }

  // Method to get total price
  double get totalPrice {
    return _products.fold(0, (sum, product) => sum + product.price);
  }
}
