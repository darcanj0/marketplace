import 'dart:convert';

import 'package:clothing/constants/server.dart';
import 'package:clothing/helpers/http_exception.dart';
import 'package:clothing/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderListProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];
  int get ordersCount => _orders.length;

  Future<void> addOrder(Cart cart) async {
    final orderedAt = DateTime.now();
    final response = await http.post(
        Uri.https(ServerConstants.domain,
            ServerConstants.getAndCreatePath(ApiPaths.orders)),
        body: jsonEncode({
          'itemsCount': cart.itemsCount.toString(),
          'totalPrice': cart.totalPrice.toStringAsFixed(2),
          'orderedAt': orderedAt.toIso8601String(),
          'items': cart.items.values
              .map<Map<String, String>>((cartItem) => {
                    'id': cartItem.id,
                    'unitPrice': cartItem.price.toStringAsFixed(2),
                    'title': cartItem.productTitle,
                    'quantity': cartItem.quantity.toString()
                  })
              .toList()
        }));
    if (response.statusCode >= 400) {
      throw AppHttpException(
          statusCode: response.statusCode,
          msg:
              'An error occurred when trying to complete order. [CODE ${response.statusCode}]');
    }
    final String createdId = jsonDecode(response.body)['name'];
    _orders.insert(
      0,
      Order(
        id: createdId,
        totalPrice: cart.totalPrice,
        items: cart.items.values.toList(),
        orderedAt: orderedAt,
      ),
    );
    notifyListeners();
  }

  Future<void> loadOrders() async {
    final response = await http.get(Uri.https(ServerConstants.domain,
        ServerConstants.getAndCreatePath(ApiPaths.orders)));
    if (response.statusCode >= 400) {
      throw AppHttpException(
          statusCode: response.statusCode,
          msg: 'There was an error when loading your orders');
    }
    _orders.clear();
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
