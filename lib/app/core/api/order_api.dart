import 'package:simple_shopping/app/core/api_client/api_client.dart';
import 'package:simple_shopping/app/data/models/body/checkout_body_model.dart';

class OrderAPI {
  OrderAPI._();

  static Future<void> checkout({
    required CheckoutBody body,
  }) async {
    try {
      const apiPath = '/orders/checkout';
      await APIClient.instance.post(
        apiPath,
        data: body.toJson(),
      );

      return;
    } catch (error) {
      rethrow;
    }
  }
}
