import 'package:flutter_test/flutter_test.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';

void main() {
  group('Product Model', () {
    test('supports value equality', () {
      final product1 = const Product(
        id: 1,
        name: 'Product A',
        price: 200.00,
      );

      final product2 = const Product(
        id: 1,
        name: 'Product A',
        price: 200.00,
      );

      final product3 = const Product(
        id: 2,
        name: 'Product B',
        price: 150.00,
      );

      expect(product1, equals(product2));
      expect(product2, isNot(equals(product3)));
    });

    test('fromJson creates Product from JSON', () {
      final product = Product.fromJson(
        const {
          'id': 1,
          'name': 'Product A',
          'price': 200.00,
        },
      );

      expect(product.id, 1);
      expect(product.name, 'Product A');
      expect(product.price, 200.00);
    });

    test('toJson converts Product to JSON', () {
      final product = const Product(
        id: 1,
        name: 'Product A',
        price: 200.00,
      );

      final json = product.toJson();

      expect(json, {
        'id': 1,
        'name': 'Product A',
        'price': 200.00,
      });
    });
  });
}
