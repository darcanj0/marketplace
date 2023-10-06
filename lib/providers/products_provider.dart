import 'dart:math';

import 'package:clothing/model/product.dart';
import 'package:flutter/foundation.dart';

class ProductListProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final List<Product> _products = mockProducts;

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts =>
      [..._products.where((element) => element.isFavorite)];

  void addProductFromData(Map<String, Object> productData) {
    final Product product = Product(
      id: Random().nextInt(1000000).toString(),
      title: productData['title'] as String,
      description: productData['description'] as String,
      price: productData['price'] as double,
      imageUrl: productData['imageUrl'] as String,
    );
    return addProduct(product);
  }

  void addProduct(Product product) {
    bool invalidId = _products.any((element) => element.id == product.id);
    if (invalidId) return;
    _products.add(product);
    notifyListeners();
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
