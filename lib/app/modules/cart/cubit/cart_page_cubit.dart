import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_shopping/app/core/api/order_api.dart';
import 'package:simple_shopping/app/data/models/body/checkout_body_model.dart';
import 'package:simple_shopping/app/data/models/cart_item_model.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';
import 'package:simple_shopping/app/managers/session/session_cubit.dart';
import 'package:simple_shopping/app/modules/cart/cubit/cart_page_state.dart';

class CartPageCubit extends Cubit<CartPageState> {
  CartPageCubit() : super(const CartPageState());

  void increaseProductQuantity(Product product) {
    SessionCubit.instance.increaseProductQuantity(product);
  }

  void decreaseProductQuantity(Product product) {
    SessionCubit.instance.decreaseProductQuantity(product);
  }

  void removeCartItem(CartItem cartItem) {
    SessionCubit.instance.removeCartItem(cartItem);
  }

  void checkout() async {
    try {
      emit(state.loading());

      final cartItems = SessionCubit.instance.state.cartItems;

      await OrderAPI.checkout(
        body: CheckoutBody(
          products: cartItems
              .map(
                (e) => e.product.id,
              )
              .whereNotNull()
              .toList(),
        ),
      );

      SessionCubit.instance.clearCart();

      emit(state.checkoutSuccess());
    } catch (error) {
      emit(state.failure(error));
    }
  }
}
