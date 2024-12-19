class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final double rating;
  final String description; // New field for description

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
    required this.description, // Initialize the description
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'rating': rating,
      'description': description, // Include description in map
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      image: map['image'],
      rating: map['rating'],
      description: map['description'], // Parse description
    );
  }
}
