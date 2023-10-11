import 'cart.dart';

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
