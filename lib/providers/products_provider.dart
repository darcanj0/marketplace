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

  Future<void> saveProductFromData(Map<String, Object> productData) {
    final Product product = Product(
      id: productData['id'] as String? ?? '',
      title: productData['title'] as String,
      description: productData['description'] as String,
      price: productData['price'] as double,
      imageUrl: productData['imageUrl'] as String,
    );
    return saveProduct(product);
  }

  Future<void> saveProduct(Product product) {
    bool mustUpdate = product.id.isNotEmpty;
    if (mustUpdate) {
      //update product
      Map<String, String> body = {
        'title': product.title,
        'description': product.description,
        'price': product.price.toStringAsFixed(2),
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite.toString(),
      };

      final req = http.patch(Uri.https(domain, updatePath(product.id)),
          body: jsonEncode(body));

      return req.then<void>((_) {
        int foundIndex = products.indexWhere(
          (element) => element.id == product.id,
        );
        _products[foundIndex] = product;
        notifyListeners();
      });
    } else {
      //create product
      Map<String, String> body = {
        'title': product.title,
        'description': product.description,
        'price': product.price.toStringAsFixed(2),
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite.toString(),
      };
      final req =
          http.post(Uri.https(domain, createPath), body: jsonEncode(body));

      return req.then<void>((response) {
        final String createdId = jsonDecode(response.body)['name'];
        final Product productToAdd = Product(
          id: createdId,
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
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
