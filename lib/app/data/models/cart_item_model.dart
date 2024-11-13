import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
        product,
        quantity,
      ];

  String id() {
    return [
      product.id,
      product.name,
      product.price,
    ].whereNotNull().join('_');
  }

  num subtotal() {
    return (product.price ?? 0) * quantity;
  }

  num discount() {
    return quantity.isEven
        ? subtotal() * -0.05
        : (product.price ?? 0) * (quantity - 1) * -0.05;
  }

  num total() {
    return subtotal() + discount();
  }
}
