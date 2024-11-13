import 'package:flutter/material.dart';
import 'package:simple_shopping/generated/app_localizations.dart';

class CartPageCheckoutSuccess extends StatelessWidget {
  final VoidCallback onTapShopAgaing;

  const CartPageCheckoutSuccess({
    super.key,
    required this.onTapShopAgaing,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            localizations.cartPageCheckoutSuccessTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            localizations.cartPageCheckoutSuccessMessage,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: onTapShopAgaing,
            child: Text(
              localizations.cartPageCheckoutSuccessShopAgain,
            ),
          ),
        ],
      ),
    );
  }
}
