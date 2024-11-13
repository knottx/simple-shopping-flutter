import 'package:json_annotation/json_annotation.dart';

part 'checkout_body_model.g.dart';

@JsonSerializable(createFactory: false)
class CheckoutBody {
  /// List of product id
  final List<int> products;

  const CheckoutBody({
    required this.products,
  });

  Map<String, dynamic> toJson() => _$CheckoutBodyToJson(this);
}
