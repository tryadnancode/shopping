import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import 'checkout_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final Cart cart; // Pass the cart to the product details screen

  const ProductDetailsScreen({Key? key, required this.product, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Image.asset(
                product.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image, size: 100),
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 16),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < product.rating.toInt()
                      ? Icons.star
                      : Icons.star_border,
                  size: 20,
                  color: Colors.orange,
                );
              }),
            ),
            SizedBox(height: 16),
            Text(
              'Product Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add product to cart
                    cart.addProduct(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart')),
                    );
                  },
                  child: Text('Add to Cart'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(cart: cart),
                      ),
                    );
                  },
                  child: Text('Buy Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
