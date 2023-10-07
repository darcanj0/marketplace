import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clothing/model/product.dart';
import 'package:flutter/foundation.dart';

class ProductListProvider with ChangeNotifier, DiagnosticableTreeMixin {
  static const String domain = 'marketplace-e37b2-default-rtdb.firebaseio.com';
  static const String createPath = '/products.json';
  String updatePath(String id) => '/products/$id.json';

  final List<Product> _products = mockProducts;

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts =>
      [..._products.where((element) => element.isFavorite)];

  Future<void> saveProduct(Map<String, String> productData) {
    productData['id'] = productData['id'] ?? '';
    bool mustUpdate = productData['id']!.isNotEmpty;
    if (mustUpdate) {
      final String title = productData['title'] as String;
      final String productId = productData['id'] as String;
      final String imageUrl = productData['imageUrl'] as String;
      final String description = productData['description'] as String;
      final double price = double.parse(productData['price'] as String);
      final bool isFavorite = (productData['isFavorite'] ?? false) as bool;

      final req = http.patch(
        Uri.https(domain, updatePath(productId)),
        body: jsonEncode({
          'title': title,
          'description': description,
          'price': price.toStringAsFixed(2),
          'imageUrl': imageUrl,
          'isFavorite': isFavorite.toString(),
        }),
      );

      return req.then<void>((_) {
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
      });
    } else {
      //create product
      final String title = productData['title'] as String;
      final String imageUrl = productData['imageUrl'] as String;
      final String description = productData['description'] as String;
      final double price = double.parse(productData['price'] as String);
      final bool isFavorite = (productData['isFavorite'] ?? false) as bool;

      final req = http.post(Uri.https(domain, createPath),
          body: jsonEncode({
            'title': title,
            'description': description,
            'price': price.toStringAsFixed(2), //two deci
            'imageUrl': imageUrl,
            'isFavorite': isFavorite.toString(),
          }));

      return req.then<void>((response) {
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
      });
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
