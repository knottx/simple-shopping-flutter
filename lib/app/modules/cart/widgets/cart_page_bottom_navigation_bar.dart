import 'package:flutter/material.dart';
import 'package:simple_shopping/app/managers/session/session_state.dart';
import 'package:simple_shopping/app/utils/app_number_formatter.dart';
import 'package:simple_shopping/generated/app_localizations.dart';

class CartPageBottomNavigationBar extends StatelessWidget {
  final SessionState sessionState;
  final VoidCallback onTapCheckout;

  const CartPageBottomNavigationBar({
    super.key,
    required this.sessionState,
    required this.onTapCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Visibility(
      visible: sessionState.isCartNotEmpty(),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: theme.colorScheme.primaryContainer,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.cartPageSubtotal,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    AppNumberFormatter.currency(sessionState.cartSubtotal()) ??
                        '',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.cartPagePromotionDiscount,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    AppNumberFormatter.currency(sessionState.cartDiscount()) ??
                        '',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppNumberFormatter.currency(sessionState.cartTotal()) ??
                          '',
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  FilledButton(
                    onPressed: onTapCheckout,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                    ),
                    child: Text(
                      localizations.cartPageCheckout,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
