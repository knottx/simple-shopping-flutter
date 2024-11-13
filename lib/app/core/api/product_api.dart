import 'package:simple_shopping/app/core/api_client/api_client.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';

class ProductAPI {
  ProductAPI._();

  static Future<List<Product>> getProducts() async {
    try {
      const apiPath = '/products';
      final response = await APIClient.instance.get(
        apiPath,
        queryParameters: {
          'limit': 20,
        },
      );

      List<Product> result = [];
      final data = response.data['items'];
      if (data is List) {
        data.forEach((e) {
          result.add(Product.fromJson(e));
        });
      }

      return result;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<Product>> getRecommendedProducts() async {
    try {
      const apiPath = '/recommended-products';
      final response = await APIClient.instance.get(
        apiPath,
      );

      List<Product> result = [];
      final data = response.data;
      if (data is List) {
        data.forEach((e) {
          result.add(Product.fromJson(e));
        });
      }

      return result;
    } catch (error) {
      rethrow;
    }
  }
}
