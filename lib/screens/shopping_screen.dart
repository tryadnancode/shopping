import 'package:flutter/material.dart';
import 'package:shopping/screens/product_details_screen.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../services/database_services.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  late Future<List<Product>> _products;
  List<Product> _filteredProducts = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _products = DatabaseService().fetchProducts();
    _products.then((value) {
      setState(() {
        _filteredProducts = value;
      });
    });
  }

  // Function to filter products based on search query
  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = _filteredProducts
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Shopping'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(_filteredProducts),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available.'));
          } else {
            final products = _filteredProducts.isEmpty ? snapshot.data! : _filteredProducts;
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            );
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  Cart cart = Cart();

  ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product, cart: cart,),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Image.asset(
                product.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('\$${product.price.toStringAsFixed(2)}'),
                  SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < product.rating.toInt()
                            ? Icons.star
                            : Icons.star_border,
                        size: 16,
                        color: Colors.orange,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate<Product?> {
  final List<Product> products;
  Cart cart = Cart();
  ProductSearchDelegate(this.products);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear search query
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products
        .where((product) =>
        product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(child: Text('No products found.'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          onTap: () {
            // Navigate to the product details screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(product: product, cart: cart,),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((product) =>
        product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          onTap: () {
            query = product.name;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // We can pass `null` since the return type is nullable
      },
    );
  }
}
