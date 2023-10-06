import 'dart:math';

import 'package:clothing/model/product.dart';
import 'package:flutter/foundation.dart';

class ProductListProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final List<Product> _products = mockProducts;

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts =>
      [..._products.where((element) => element.isFavorite)];

  void saveProductFromData(Map<String, Object> productData) {
    bool hasId = productData['id'] != null;
    final Product product = Product(
      id: hasId
          ? productData['id'] as String
          : Random().nextInt(1000000).toString(),
      title: productData['title'] as String,
      description: productData['description'] as String,
      price: productData['price'] as double,
      imageUrl: productData['imageUrl'] as String,
    );
    return saveProduct(product);
  }

  void saveProduct(Product product) {
    int foundIndex =
        _products.indexWhere((element) => element.id == product.id);
    bool mustUpdate = foundIndex != -1;

    if (mustUpdate) {
      _products[foundIndex] = product;
    } else {
      _products.add(product);
    }

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
