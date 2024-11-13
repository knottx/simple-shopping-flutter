import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_shopping/app/core/api/product_api.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';
import 'package:simple_shopping/app/managers/session/session_cubit.dart';
import 'package:simple_shopping/app/modules/shopping/cubit/shopping_page_state.dart';

class ShoppingPageCubit extends Cubit<ShoppingPageState> {
  ShoppingPageCubit() : super(const ShoppingPageState()) {
    loadData();
  }

  void loadData() async {
    getRecommendedProducts();
    getProducts();
  }

  void getRecommendedProducts() async {
    try {
      emit(state.recommendedProductsLoading());
      final result = await ProductAPI.getRecommendedProducts();
      emit(
        state.recommendedProductsReady(
          recommendedProducts: result,
        ),
      );
    } catch (error) {
      emit(state.recommendedProductsFailure(error));
    }
  }

  void getProducts() async {
    try {
      emit(state.productsLoading());
      final result = await ProductAPI.getProducts();
      emit(
        state.productsReady(
          products: result,
        ),
      );
    } catch (error) {
      emit(state.productsFailure(error));
    }
  }

  void increaseProductQuantity(Product product) {
    SessionCubit.instance.increaseProductQuantity(product);
  }

  void decreaseProductQuantity(Product product) {
    SessionCubit.instance.decreaseProductQuantity(product);
  }
}
