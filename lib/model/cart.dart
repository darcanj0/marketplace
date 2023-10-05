import 'dart:math';

import 'package:clothing/model/product.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemsCount => items.length;

  double get totalPrice {
    double total = 0;
    items.forEach((key, value) => total += value.price * value.quantity);
    return total;
  }

  void addProduct(Product product) {
    if (items.containsKey(product.id)) {
      _items.update(
        product.id,
        (value) => CartItem(
          id: value.id,
          productId: value.productId,
          productTitle: value.productTitle,
          imageUrl: product.imageUrl,
          price: value.price,
          quantity: value.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          productTitle: product.title,
          price: product.price,
          imageUrl: product.imageUrl,
          quantity: 1,
        ),
      );
    }
    print(_items);
    notifyListeners();
  }

  void removeProduct(String productId) {
    items.remove(productId);
    notifyListeners();
  }

  void emptyCart() {
    _items = {};
    notifyListeners();
  }

  Cart();
}

class CartItem {
  final String id;
  final String productId;
  final String productTitle;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}
