import 'package:equatable/equatable.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';

enum ShoppingPageStatus {
  initial,
  loading,
  ready,
  failure,
  ;

  bool get isLoading => this == ShoppingPageStatus.loading;
  bool get isFailure => this == ShoppingPageStatus.failure;
}

class ShoppingPageState extends Equatable {
  final ShoppingPageStatus recommendedProductsStatus;
  final List<Product> recommendedProducts;
  final Object? recommendedProductsError;

  final ShoppingPageStatus productsStatus;
  final List<Product> products;
  final Object? productsError;

  const ShoppingPageState({
    this.recommendedProductsStatus = ShoppingPageStatus.initial,
    this.recommendedProducts = const [],
    this.recommendedProductsError,
    this.productsStatus = ShoppingPageStatus.initial,
    this.products = const [],
    this.productsError,
  });

  @override
  List<Object?> get props => [
        recommendedProductsStatus,
        recommendedProducts,
        recommendedProductsError,
        productsStatus,
        products,
        productsError,
      ];

  ShoppingPageState copyWith({
    ShoppingPageStatus? recommendedProductsStatus,
    List<Product>? recommendedProducts,
    Object? recommendedProductsError,
    ShoppingPageStatus? productsStatus,
    List<Product>? products,
    Object? productsError,
  }) {
    return ShoppingPageState(
      recommendedProductsStatus:
          recommendedProductsStatus ?? this.recommendedProductsStatus,
      recommendedProducts: recommendedProducts ?? this.recommendedProducts,
      recommendedProductsError:
          recommendedProductsError ?? this.recommendedProductsError,
      productsStatus: productsStatus ?? this.productsStatus,
      products: products ?? this.products,
      productsError: productsError ?? this.productsError,
    );
  }

  ShoppingPageState recommendedProductsLoading() {
    return copyWith(
      recommendedProductsStatus: ShoppingPageStatus.loading,
    );
  }

  ShoppingPageState recommendedProductsReady({
    List<Product>? recommendedProducts,
  }) {
    return copyWith(
      recommendedProductsStatus: ShoppingPageStatus.ready,
      recommendedProducts: recommendedProducts,
    );
  }

  ShoppingPageState recommendedProductsFailure(
    Object recommendedProductsError,
  ) {
    return copyWith(
      recommendedProductsStatus: ShoppingPageStatus.failure,
      recommendedProductsError: recommendedProductsError,
    );
  }

  ShoppingPageState productsLoading() {
    return copyWith(
      productsStatus: ShoppingPageStatus.loading,
    );
  }

  ShoppingPageState productsReady({
    List<Product>? products,
  }) {
    return copyWith(
      productsStatus: ShoppingPageStatus.ready,
      products: products,
    );
  }

  ShoppingPageState productsFailure(
    Object error,
  ) {
    return copyWith(
      productsStatus: ShoppingPageStatus.failure,
      productsError: productsError,
    );
  }
}
