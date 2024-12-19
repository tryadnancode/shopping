import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: widget.cart.products.isEmpty
          ? Center(child: Text('Your cart is empty.'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.products.length,
              itemBuilder: (context, index) {
                final product = widget.cart.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      setState(() {
                        widget.cart.removeProduct(product);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${widget.cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(cart: widget.cart),
                      ),
                    );
                  },
                  child: Text('Proceed to Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
