import 'package:flutter/material.dart';
import 'package:simple_shopping/app/managers/session/session_state.dart';
import 'package:simple_shopping/app/utils/app_number_formatter.dart';
import 'package:simple_shopping/generated/app_localizations.dart';

class CartPageBottomNavigationBar extends StatefulWidget {
  final SessionState sessionState;
  final VoidCallback onTapCheckout;
  final void Function(String) onApplyCoupon;

  const CartPageBottomNavigationBar({
    super.key,
    required this.sessionState,
    required this.onTapCheckout,
    required this.onApplyCoupon,
  });

  @override
  State<CartPageBottomNavigationBar> createState() =>
      _CartPageBottomNavigationBarState();
}

class _CartPageBottomNavigationBarState
    extends State<CartPageBottomNavigationBar> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final couponDiscount = widget.sessionState.couponDiscount();
    return Visibility(
      visible: widget.sessionState.isCartNotEmpty(),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: theme.colorScheme.primaryContainer,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textEditingController,
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      widget.onApplyCoupon(_textEditingController.text);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.cartPageSubtotal,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    AppNumberFormatter.currency(
                          widget.sessionState.cartSubtotal(),
                        ) ??
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
                    AppNumberFormatter.currency(
                          widget.sessionState.cartDiscount(),
                        ) ??
                        '',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              if (couponDiscount < 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Coupon discount',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      AppNumberFormatter.currency(couponDiscount) ?? '',
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
                      AppNumberFormatter.currency(
                            widget.sessionState.cartTotal(),
                          ) ??
                          '',
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  FilledButton(
                    onPressed: widget.onTapCheckout,
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
