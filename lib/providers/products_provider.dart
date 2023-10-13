import 'package:clothing/helpers/http_exception.dart';
import 'package:clothing/providers/db_provider.dart';
import 'package:clothing/model/product.dart';
import 'package:flutter/foundation.dart';

class ProductListProvider extends DbProvider
    with ChangeNotifier, DiagnosticableTreeMixin {
  ProductListProvider({required super.dbPath});

  final List<Product> _products = [];

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts =>
      [..._products.where((element) => element.isFavorite)];

  Future<void> loadProducts() async {
    _products.clear();

    try {
      final snapshot = await readRef.get();
      if (snapshot.exists) {
        final dynamic productsData = snapshot.value;
        productsData.forEach((id, productData) {
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
      } else {
        throw AppHttpException(statusCode: 400, msg: 'No products found');
      }
    } catch (e) {
      throw AppHttpException(
          statusCode: 400, msg: 'An error occurred when loading products');
    }

    notifyListeners();
  }

  Future<void> saveProductFromData(Map<String, String> productData) async {
    productData['id'] = productData['id'] ?? '';
    bool mustUpdate = productData['id']!.isNotEmpty;
    if (mustUpdate) {
      final String title = productData['title'] as String;
      final String productId = productData['id'] as String;
      final String imageUrl = productData['imageUrl'] as String;
      final String description = productData['description'] as String;
      final double price = double.parse(productData['price'] as String);

      try {
        await getReferenceFrom(productId).update({
          'title': title,
          'description': description,
          'price': price.toStringAsFixed(2),
          'imageUrl': imageUrl,
        });
      } catch (e) {
        throw AppHttpException(
            statusCode: 400, msg: 'An error occurred while updating product');
      }
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

      final String createdId = idGenerator.newId();
      try {
        await getReferenceFrom(createdId).set({
          'title': title,
          'description': description,
          'price': price.toStringAsFixed(2), //two decimal
          'imageUrl': imageUrl,
          'isFavorite': isFavorite.toString(),
        });
      } catch (e) {
        throw AppHttpException(
            statusCode: 400,
            msg: 'There was an error while saving the product');
      }

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

  Future<void> deleteProduct(Product product) async {
    int foundIndex =
        _products.indexWhere((element) => element.id == product.id);
    final bool canDelete = foundIndex >= 0;
    if (canDelete) {
      _products.remove(_products[foundIndex]);
      notifyListeners();

      try {
        await getReferenceFrom(product.id).remove();
      } catch (e) {
        _products.insert(foundIndex, product);
        notifyListeners();
        throw AppHttpException(
            statusCode: 400,
            msg: 'There was an error while deleting the product');
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('products', products));
  }
}
