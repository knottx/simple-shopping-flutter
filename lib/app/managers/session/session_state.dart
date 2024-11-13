import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_shopping/app/data/models/cart_item_model.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';

class SessionState extends Equatable {
  final List<CartItem> cartItems;

  const SessionState({
    this.cartItems = const [],
  });

  @override
  List<Object?> get props => [
        cartItems,
      ];

  SessionState copyWith({
    List<CartItem>? cartItems,
    Object? error,
  }) {
    return SessionState(
      cartItems: cartItems ?? this.cartItems,
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

  num cartTotal() {
    return cartSubtotal() + cartDiscount();
  }
}
