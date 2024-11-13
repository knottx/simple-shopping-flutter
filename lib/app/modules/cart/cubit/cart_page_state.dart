import 'package:equatable/equatable.dart';

enum CartPageStatus {
  initial,
  loading,
  checkoutSuccess,
  failure,
  ;

  bool get isLoading => this == CartPageStatus.loading;
  bool get isCheckoutSuccess => this == CartPageStatus.checkoutSuccess;
}

class CartPageState extends Equatable {
  final CartPageStatus status;
  final Object? error;

  const CartPageState({
    this.status = CartPageStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        error,
      ];

  CartPageState copyWith({
    CartPageStatus? status,
    Object? error,
  }) {
    return CartPageState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  CartPageState loading() {
    return copyWith(
      status: CartPageStatus.loading,
    );
  }

  CartPageState checkoutSuccess() {
    return copyWith(
      status: CartPageStatus.checkoutSuccess,
    );
  }

  CartPageState failure(
    Object error,
  ) {
    return copyWith(
      status: CartPageStatus.failure,
      error: error,
    );
  }
}
