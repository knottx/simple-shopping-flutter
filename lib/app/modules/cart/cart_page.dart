import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_shopping/app/global_widgets/overlay_loading_indicator.dart';
import 'package:simple_shopping/app/managers/session/session_cubit.dart';
import 'package:simple_shopping/app/managers/session/session_state.dart';
import 'package:simple_shopping/app/modules/cart/cubit/cart_page_cubit.dart';
import 'package:simple_shopping/app/modules/cart/cubit/cart_page_state.dart';
import 'package:simple_shopping/app/modules/cart/widgets/cart_page_bottom_navigation_bar.dart';
import 'package:simple_shopping/app/modules/cart/widgets/cart_page_cart_item_tile.dart';
import 'package:simple_shopping/app/modules/cart/widgets/cart_page_checkout_success.dart';
import 'package:simple_shopping/app/modules/cart/widgets/cart_page_empty.dart';
import 'package:simple_shopping/app/utils/app_snack_bar.dart';
import 'package:simple_shopping/generated/app_localizations.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartPageCubit(),
      child: const CartView(),
    );
  }
}

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartPageCubit get _cubit {
    return context.read<CartPageCubit>();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartPageCubit, CartPageState>(
      builder: (context, state) {
        return BlocBuilder<SessionCubit, SessionState>(
          builder: (context, sessionState) {
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    title: Text(
                      AppLocalizations.of(context).cartPageAppBarTitle,
                    ),
                    centerTitle: true,
                  ),
                  body: _body(
                    state: state,
                    sessionState: sessionState,
                  ),
                  bottomNavigationBar: CartPageBottomNavigationBar(
                    sessionState: sessionState,
                    onTapCheckout: _cubit.checkout,
                    onApplyCoupon: _cubit.onApplyCoupon,
                  ),
                ),
                OverlayLoadingIndicator(state.status.isLoading),
              ],
            );
          },
        );
      },
      listener: _listener,
    );
  }

  Widget _body({
    required CartPageState state,
    required SessionState sessionState,
  }) {
    final cartItems = sessionState.cartItems;
    return (sessionState.isCartNotEmpty())
        ? Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return CartPageCartItemTile(
                  cartItem: cartItem,
                  onDismissed: () {
                    _cubit.removeCartItem(cartItem);
                  },
                  onTapAdd: () {
                    _cubit.increaseProductQuantity(cartItem.product);
                  },
                  onTapRemove: () {
                    _cubit.decreaseProductQuantity(cartItem.product);
                  },
                );
              },
            ),
          )
        : SafeArea(
            child: state.status.isCheckoutSuccess
                ? CartPageCheckoutSuccess(
                    onTapShopAgaing: context.pop,
                  )
                : CartPageEmpty(
                    onTapGoToShopping: context.pop,
                  ),
          );
  }

  void _listener(BuildContext context, CartPageState state) {
    switch (state.status) {
      case CartPageStatus.initial:
      case CartPageStatus.loading:
      case CartPageStatus.ready:
      case CartPageStatus.checkoutSuccess:
        break;

      case CartPageStatus.failure:
        AppSnackBar.error(context, error: state.error);
        break;
    }
  }
}
