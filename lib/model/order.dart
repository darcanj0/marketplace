import 'dart:math';

import 'package:clothing/model/cart.dart';
import 'package:flutter/material.dart';

class OrderList with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];
  int get ordersCount => _orders.length;

  void addOrder(Cart cart) {
    _orders.insert(
      0,
      Order(
          id: Random().nextDouble().toString(),
          totalPrice: cart.totalPrice,
          items: cart.items.values.toList(),
          orderedAt: DateTime.now()),
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
