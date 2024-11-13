import 'package:flutter/material.dart';
import 'package:simple_shopping/app/data/models/cart_item_model.dart';
import 'package:simple_shopping/app/global_widgets/product_tile.dart';

class CartPageCartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onDismissed;
  final VoidCallback onTapAdd;
  final VoidCallback onTapRemove;

  const CartPageCartItemTile({
    super.key,
    required this.cartItem,
    required this.onDismissed,
    required this.onTapAdd,
    required this.onTapRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartItem.id()),
      onDismissed: (diretion) {
        onDismissed();
      },
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: const Row(
          children: [
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 1,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      child: ProductTile(
        product: cartItem.product,
        cartQuantity: cartItem.quantity,
        onTapAdd: onTapAdd,
        onTapRemove: onTapRemove,
      ),
    );
  }
}
