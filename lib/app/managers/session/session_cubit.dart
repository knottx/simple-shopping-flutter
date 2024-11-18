import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_shopping/app/data/models/app_error_model.dart';
import 'package:simple_shopping/app/data/models/cart_item_model.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';
import 'package:simple_shopping/app/managers/session/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  static final SessionCubit instance = SessionCubit._();

  SessionCubit._() : super(const SessionState());

  void increaseProductQuantity(Product product) {
    var cartItems = List<CartItem>.from(state.cartItems);
    final index = cartItems.indexWhere((e) => e.product == product);
    if (index >= 0) {
      final quantity = cartItems[index].quantity + 1;
      cartItems[index] = CartItem(
        product: product,
        quantity: quantity,
      );
    } else {
      cartItems.add(
        CartItem(
          product: product,
          quantity: 1,
        ),
      );
    }
    emit(state.copyWith(cartItems: cartItems));
  }

  void decreaseProductQuantity(Product product) {
    var cartItems = List<CartItem>.from(state.cartItems);
    final index = cartItems.indexWhere((e) => e.product == product);
    if (index >= 0) {
      final quantity = cartItems[index].quantity - 1;
      if (quantity > 0) {
        cartItems[index] = CartItem(
          product: product,
          quantity: quantity,
        );
      } else {
        cartItems.removeAt(index);
      }
      emit(state.copyWith(cartItems: cartItems));
    }
  }

  void removeCartItem(CartItem cartItem) {
    var cartItems = List<CartItem>.from(state.cartItems);
    cartItems.removeWhere((e) => e == cartItem);
    emit(state.copyWith(cartItems: cartItems));
  }

  void clearCart() {
    emit(state.copyWith(cartItems: []));
  }

  void applyCoupon(String couponCode) {
    if (couponCode == 'DISCOUNT100') {
      emit(state.copyWith(couponCode: couponCode));
    } else {
      emit(state.copyWith(couponCode: ''));
      throw const AppError(message: 'The coupon code is invalid');
    }
  }
}
