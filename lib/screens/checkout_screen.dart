import 'package:flutter/material.dart';
import '../models/cart_model.dart'; // Cart model should be imported here.

class CheckoutScreen extends StatelessWidget {
  final Cart cart;

  const CheckoutScreen({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: cart.products.length,
              itemBuilder: (context, index) {
                final product = cart.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                );
              },
            ),
            SizedBox(height: 16),
            Text(
              'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Credit Card'),
              leading: Radio<String>(
                value: 'Credit Card',
                groupValue: 'Credit Card',
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: Text('PayPal'),
              leading: Radio<String>(
                value: 'PayPal',
                groupValue: 'Credit Card',
                onChanged: (value) {},
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle order confirmation
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Confirm Order'),
                      content: Text('Do you want to place the order?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Confirm order and proceed to confirmation screen
                            Navigator.pop(context);
                            Navigator.pop(context); // Navigate back to cart screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Order placed successfully!')),
                            );
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}
