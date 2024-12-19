import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'shopping.db');

    print("Opening database at path: $path"); // Debugging log
    return openDatabase(
      path,
      version: 2, // Increment the version number
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY,
        name TEXT,
        price REAL,
        image TEXT,
        rating REAL,
        description TEXT
      )
    ''');
        await _populateProducts(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE products ADD COLUMN description TEXT');
        }
      },
    );
    ;
  }

  Future<void> _populateProducts(Database db) async {
    print("Populating products...");

    // Clear the products table before inserting new products
    await db.delete('products'); // This clears any existing data
    print("Deleted previous products.");

    final products = [
      Product(
        id: 1,
        name: 'Laptop',
        price: 999.99,
        image: 'assets/images/img.png',
        rating: 4.5,
        description: 'A high-performance laptop for professionals and gamers.',
      ),
      Product(
        id: 2,
        name: 'Smartphone',
        price: 699.99,
        image: 'assets/images/img_1.png',
        rating: 4.0,
        description: 'A powerful smartphone with cutting-edge features.',
      ),
      Product(
        id: 3,
        name: 'Headphones',
        price: 199.99,
        image: 'assets/images/img_2.png',
        rating: 4.8,
        description: 'Noise-cancelling headphones for immersive sound quality.',
      ),
      Product(
        id: 4,
        name: 'Keyboard',
        price: 49.99,
        image: 'assets/images/img_3.png',
        rating: 4.3,
        description: 'Ergonomic keyboard designed for comfort and efficiency.',
      ),
    ];

    for (var product in products) {
      await db.insert('products', product.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print("Inserted product: ${product.name}"); // Log each product inserted
    }

    // Check if products are inserted
    final insertedProducts = await db.query('products');
    print("Inserted products: ${insertedProducts.length}");
    insertedProducts.forEach((product) {
      print("Product in DB: ${product['name']}, ${product['price']}");
    });

    print("Products populated successfully.");
  }

  Future<List<Product>> fetchProducts() async {
    final db = await database;
    final maps = await db.query('products');
    print("Fetched products: ${maps.length}"); // Debugging output
    return List<Product>.from(maps.map((map) => Product.fromMap(map)));
  }
}
