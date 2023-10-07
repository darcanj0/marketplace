import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clothing/model/product.dart';
import 'package:flutter/foundation.dart';

class ProductListProvider with ChangeNotifier, DiagnosticableTreeMixin {
  static const String domain = 'marketplace-e37b2-default-rtdb.firebaseio.com';
  static const String getAndCreatePath = '/products.json';
  String updatePath(String id) => '/products/$id.json';

  final List<Product> _products = mockProducts;

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts =>
      [..._products.where((element) => element.isFavorite)];

  Future<void> loadProducts() async {
    _products.clear();
    final response = await http.get(Uri.https(domain, getAndCreatePath));
    var decodedData = jsonDecode(response.body);
    decodedData.forEach((id, productData) {
      final Product loadedProduct = Product(
        id: id,
        title: productData['title'] as String,
        description: productData['description'] as String,
        price: double.parse(productData['price'] as String),
        imageUrl: productData['imageUrl'] as String,
        isFavorite: bool.parse(productData['isFavorite']),
      );
      _products.add(loadedProduct);
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, String> productData) async {
    productData['id'] = productData['id'] ?? '';
    bool mustUpdate = productData['id']!.isNotEmpty;
    if (mustUpdate) {
      final String title = productData['title'] as String;
      final String productId = productData['id'] as String;
      final String imageUrl = productData['imageUrl'] as String;
      final String description = productData['description'] as String;
      final double price = double.parse(productData['price'] as String);
      final bool isFavorite = (productData['isFavorite'] ?? false) as bool;

      final response = await http.patch(
        Uri.https(domain, updatePath(productId)),
        body: jsonEncode({
          'title': title,
          'description': description,
          'price': price.toStringAsFixed(2),
          'imageUrl': imageUrl,
          'isFavorite': isFavorite.toString(),
        }),
      );

      if (response.statusCode != 200) throw ();
      int foundIndex = products.indexWhere(
        (element) => element.id == productId,
      );
      _products[foundIndex] = Product(
        id: productId,
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
      notifyListeners();
    } else {
      //create product
      final String title = productData['title'] as String;
      final String imageUrl = productData['imageUrl'] as String;
      final String description = productData['description'] as String;
      final double price = double.parse(productData['price'] as String);
      final bool isFavorite = (productData['isFavorite'] ?? false) as bool;

      final response = await http.post(Uri.https(domain, getAndCreatePath),
          body: jsonEncode({
            'title': title,
            'description': description,
            'price': price.toStringAsFixed(2), //two decimal
            'imageUrl': imageUrl,
            'isFavorite': isFavorite.toString(),
          }));

      if (response.statusCode != 200) throw ();

      final String createdId = jsonDecode(response.body)['name'];
      final Product productToAdd = Product(
        id: createdId,
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
      _products.add(productToAdd);
      notifyListeners();
    }
  }

  void deleteProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('products', products));
  }
}
