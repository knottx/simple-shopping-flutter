import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_shopping/app/data/models/cart_item_model.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';

void main() {
  group('CartItem', () {
    final productA = const Product(
      id: 1,
      name: 'Product A',
      price: 200.00,
    );

    final productB = const Product(
      id: 2,
      name: 'Product B',
      price: 150.00,
    );

    final productC = const Product(
      id: 2,
      name: 'Product C',
      price: 100.00,
    );

    final cartItemA = CartItem(product: productA, quantity: 3);
    final cartItemB = CartItem(product: productB, quantity: 4);
    final cartItemC = CartItem(product: productC, quantity: 1);
    test('calculates subtotal correctly', () {
      expect(cartItemA.subtotal(), 600.00);
      expect(cartItemB.subtotal(), 600.00);
      expect(cartItemC.subtotal(), 100.00);
    });

    test('calculates discount correctly', () {
      expect(cartItemA.discount(), -20.00);
      expect(cartItemB.discount(), -30.00);
      expect(cartItemC.discount(), 0.00);
    });

    test('calculates total correctly', () {
      expect(cartItemA.total(), 580.00);
      expect(cartItemB.total(), 570.00);
      expect(cartItemC.total(), 100.00);

      expect(
        [
          cartItemA.total(),
          cartItemB.total(),
          cartItemC.total(),
        ].sum,
        1250.00,
      );
    });

    test('supports value equality', () {
      final cartItem1 = CartItem(product: productA, quantity: 3);
      final cartItem2 = CartItem(product: productA, quantity: 3);
      final cartItem3 = CartItem(product: productB, quantity: 4);

      expect(cartItem1, equals(cartItem2));
      expect(cartItem1, isNot(equals(cartItem3)));
    });
  });
}
