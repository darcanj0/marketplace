import 'package:clothing/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    final Cart cart = Provider.of<Cart>(context);

    return Dismissible(
      key: Key(cartItem.id),
      confirmDismiss: (_) => showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to remove this product?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('YES'),
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('NO'))
                ],
              )),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: colorScheme.error,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete_outline_rounded,
          color: colorScheme.background,
          size: 30,
        ),
      ),
      onDismissed: (_) => cart.removeProduct(cartItem.productId),
      child: Card(
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
      ),
    );
  }
}
