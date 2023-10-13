import 'package:clothing/constants/server.dart';
import 'package:clothing/helpers/http_exception.dart';
import 'package:clothing/model/cart.dart';
import 'package:clothing/model/order.dart';
import 'package:clothing/providers/db_provider.dart';
import 'package:flutter/material.dart';

class OrderListProvider extends DbProvider with ChangeNotifier {
  OrderListProvider({super.dbPath = DbPaths.orders});
  String userId = '';

  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];
  int get ordersCount => _orders.length;

  Future<void> addOrder(Cart cart) async {
    final orderedAt = DateTime.now();
    final String createdId = idGenerator.newId();
    try {
      await getReferenceFrom(userId).set({
        createdId: {
          'itemsCount': cart.itemsCount.toString(),
          'totalPrice': cart.totalPrice.toStringAsFixed(2),
          'orderedAt': orderedAt.toIso8601String(),
          'items': cart.items.values
              .map<Map<String, String>>((cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productId,
                    'unitPrice': cartItem.price.toStringAsFixed(2),
                    'title': cartItem.productTitle,
                    'quantity': cartItem.quantity.toString(),
                    'imageUrl': cartItem.imageUrl
                  })
              .toList()
        }
      });
    } catch (e) {
      throw AppHttpException(
          statusCode: 400,
          msg: 'An error occurred when trying to complete order.');
    }
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
    final snapshot = await getReferenceFrom(userId).get();
    _orders.clear();
    if (snapshot.exists) {
      try {
        final dynamic loadedData = snapshot.value ?? {};
        loadedData.forEach((orderId, orderData) {
          final List<CartItem> orderItems = [];
          (orderData['items']).forEach((itemData) {
            final CartItem item = CartItem(
              id: itemData['id'],
              productId: itemData['productId'],
              productTitle: itemData['title'],
              price: double.parse(itemData['unitPrice']),
              imageUrl: itemData['imageUrl'],
              quantity: int.parse(itemData['quantity']),
            );
            orderItems.add(item);
          });
          final Order loadedOrder = Order(
            id: orderId,
            orderedAt: DateTime.parse(orderData['orderedAt']),
            totalPrice: double.parse(orderData['totalPrice']),
            items: orderItems,
          );
          _orders.add(loadedOrder);
        });
      } catch (e) {
        throw AppHttpException(
            statusCode: 400,
            msg: 'There was an error when loading your orders');
      }
    } else {
      throw AppHttpException(statusCode: 400, msg: 'No order was found!');
    }
    notifyListeners();
  }
}
