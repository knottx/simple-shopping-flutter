import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_shopping/app/data/models/cart_item_model.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';

class SessionState extends Equatable {
  final List<CartItem> cartItems;
  final String couponCode;

  const SessionState({
    this.cartItems = const [],
    this.couponCode = '',
  });

  @override
  List<Object?> get props => [
        cartItems,
        couponCode,
      ];

  SessionState copyWith({
    List<CartItem>? cartItems,
    String? couponCode,
  }) {
    return SessionState(
      cartItems: cartItems ?? this.cartItems,
      couponCode: couponCode ?? this.couponCode,
    );
  }

  bool isCartEmpty() {
    return cartItems.isEmpty;
  }

  bool isCartNotEmpty() {
    return cartItems.isNotEmpty;
  }

  int cartQuantity() {
    return cartItems.map((e) => e.quantity).sum;
  }

  int cartQuantityProduct(Product product) {
    return cartItems
        .where((e) => e.product == product)
        .map((e) => e.quantity)
        .sum;
  }

  num cartSubtotal() {
    return cartItems.map((e) => e.subtotal()).sum;
  }

  num cartDiscount() {
    return cartItems.map((e) => e.discount()).sum;
  }

  num couponDiscount() {
    return couponCode == 'DISCOUNT100' ? -100 : 0;
  }

  num cartTotal() {
    final result = cartSubtotal() + cartDiscount() + couponDiscount();
    return result > 0 ? result : 0;
  }
}
