import 'package:clothing/model/cart.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(cartItem.imageUrl),
        ),
        title: Text(
          cartItem.productTitle,
          style: textTheme.labelLarge,
        ),
        subtitle: Text(
          '${cartItem.quantity} x U\$ ${cartItem.price}',
          style: textTheme.bodySmall,
        ),
        trailing: Text(
          'U\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
          style: textTheme.labelLarge,
        ),
      ),
    );
  }
}
