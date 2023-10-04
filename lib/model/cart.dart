import 'dart:math';

import 'package:clothing/model/product.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items => {..._items};

  int get itemsCount => items.length;

  double get totalPrice {
    double total = 0;
    items.forEach((key, value) => total += value.price * value.quantity);
    return total;
  }

  void addProduct(Product product) {
    if (items.containsKey(product.id)) {
      items.update(
        product.id,
        (value) => CartItem(
          id: value.id,
          productId: value.productId,
          productTitle: value.productTitle,
          price: value.price,
          quantity: value.quantity + 1,
        ),
      );
    } else {
      items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          productTitle: product.title,
          price: product.price,
          quantity: 1,
        ),
      );
    }
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

  Cart({required Map<String, CartItem> items}) : _items = items;
}

class CartItem {
  final String id;
  final String productId;
  final String productTitle;
  final double price;
  int quantity;

  CartItem(
      {required this.id,
      required this.productId,
      required this.productTitle,
      required this.price,
      required this.quantity});
}
