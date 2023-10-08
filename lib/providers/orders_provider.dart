import 'dart:math';

import 'package:clothing/model/cart.dart';
import 'package:flutter/material.dart';

class OrderListProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];
  int get ordersCount => _orders.length;

  void addOrder(Cart cart) {
    _orders.insert(
      0,
      Order(
        id: (Random().nextDouble() * 99999999).toStringAsFixed(0),
        totalPrice: cart.totalPrice,
        items: cart.items.values.toList(),
        orderedAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}

class Order {
  final String id;
  final double totalPrice;
  final List<CartItem> items;
  final DateTime orderedAt;

  Order(
      {required this.id,
      required this.totalPrice,
      required this.items,
      required this.orderedAt});
}
