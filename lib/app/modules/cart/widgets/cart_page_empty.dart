import 'package:flutter/material.dart';
import 'package:simple_shopping/generated/app_localizations.dart';

class CartPageEmpty extends StatelessWidget {
  final VoidCallback onTapGoToShopping;

  const CartPageEmpty({
    super.key,
    required this.onTapGoToShopping,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context).cartPageEmptyCart,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: onTapGoToShopping,
            child: Text(
              AppLocalizations.of(context).cartPageGoToShopping,
            ),
          ),
        ],
      ),
    );
  }
}
