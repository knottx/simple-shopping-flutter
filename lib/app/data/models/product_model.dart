import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final int? id;
  final String? name;
  final num? price;

  const Product({
    this.id,
    this.name,
    this.price,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
      ];

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
