import 'package:clothing/model/product.dart';
import 'package:flutter/foundation.dart';

class ProductListProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final List<Product> _products = mockProducts;

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts =>
      [..._products.where((element) => element.isFavorite)];

  void addProduct(Product product) {
    bool invalidId = _products.any((element) => element.id == product.id);
    if (invalidId) return;
    _products.add(product);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('products', products));
  }
}
