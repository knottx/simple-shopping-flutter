import 'package:flutter/material.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';
import 'package:simple_shopping/app/utils/app_number_formatter.dart';
import 'package:simple_shopping/generated/app_localizations.dart';
import 'package:simple_shopping/generated/assets.gen.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final int cartQuantity;
  final VoidCallback onTapAdd;
  final VoidCallback onTapRemove;

  const ProductTile({
    super.key,
    required this.product,
    required this.cartQuantity,
    required this.onTapAdd,
    required this.onTapRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Assets.images.placeholderProduct.image(
              height: 76,
              width: 76,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.name ?? '',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      AppNumberFormatter.currency(product.price) ?? '',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '/ ${AppLocalizations.of(context).commonUnit}',
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          (cartQuantity > 0)
              ? _adjustQuantityButtons()
              : _addToCartButton(context),
        ],
      ),
    );
  }

  Widget _adjustQuantityButtons() {
    return Row(
      children: [
        IconButton.filled(
          onPressed: onTapRemove,
          icon: const Icon(
            Icons.remove,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Text(
            cartQuantity.toString(),
          ),
        ),
        IconButton.filled(
          onPressed: onTapAdd,
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
    );
  }

  Widget _addToCartButton(BuildContext context) {
    return FilledButton(
      onPressed: onTapAdd,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
      ),
      child: Text(
        AppLocalizations.of(context).commonAddToCart,
      ),
    );
  }
}
