import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_shopping/app/data/models/product_model.dart';
import 'package:simple_shopping/app/global_widgets/product_tile.dart';
import 'package:simple_shopping/app/managers/session/session_cubit.dart';
import 'package:simple_shopping/app/managers/session/session_state.dart';
import 'package:simple_shopping/app/modules/shopping/cubit/shopping_page_cubit.dart';
import 'package:simple_shopping/app/modules/shopping/cubit/shopping_page_state.dart';
import 'package:simple_shopping/app/modules/shopping/widgets/shopping_page_failure_tile.dart';
import 'package:simple_shopping/app/utils/app_snack_bar.dart';
import 'package:simple_shopping/generated/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingPageCubit(),
      child: const ShoppingView(),
    );
  }
}

class ShoppingView extends StatefulWidget {
  const ShoppingView({super.key});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  ShoppingPageCubit get _cubit {
    return context.read<ShoppingPageCubit>();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingPageCubit, ShoppingPageState>(
      builder: (context, state) {
        return BlocBuilder<SessionCubit, SessionState>(
          builder: (context, sessionState) {
            return Scaffold(
              body: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: SafeArea(
                    child: _body(state: state, sessionState: sessionState),
                  ),
                ),
              ),
              bottomNavigationBar: _bottomNavigationBar(sessionState),
            );
          },
        );
      },
      listener: _listener,
    );
  }

  Widget _body({
    required ShoppingPageState state,
    required SessionState sessionState,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _products(
          title: AppLocalizations.of(context).shoppingPageRecommendProduct,
          status: state.recommendedProductsStatus,
          products: state.recommendedProducts,
          sessionState: sessionState,
          onTapRefresh: _cubit.getRecommendedProducts,
        ),
        _products(
          title: AppLocalizations.of(context).shoppingPageLatestProducts,
          status: state.productsStatus,
          products: state.products,
          sessionState: sessionState,
          onTapRefresh: _cubit.getProducts,
        ),
      ],
    );
  }

  Widget _products({
    required String title,
    required ShoppingPageStatus status,
    required List<Product> products,
    required SessionState sessionState,
    required VoidCallback onTapRefresh,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        status.isFailure
            ? ShoppingPageFailureTile(
                onTapRefresh: onTapRefresh,
              )
            : Skeletonizer(
                enabled: status.isLoading,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (status.isLoading && products.isEmpty)
                      ? 4
                      : products.length,
                  itemBuilder: (context, index) {
                    if (status.isLoading && products.isEmpty) {
                      return ProductTile(
                        product: const Product(),
                        cartQuantity: 0,
                        onTapAdd: () {},
                        onTapRemove: () {},
                      );
                    } else {
                      final product = products[index];
                      return ProductTile(
                        product: product,
                        cartQuantity: sessionState.cartQuantityProduct(product),
                        onTapAdd: () {
                          _cubit.increaseProductQuantity(product);
                        },
                        onTapRemove: () {
                          _cubit.decreaseProductQuantity(product);
                        },
                      );
                    }
                  },
                ),
              ),
      ],
    );
  }

  Widget _bottomNavigationBar(SessionState sessionState) {
    final cartQuantity = sessionState.cartQuantity();
    return NavigationBar(
      onDestinationSelected: (index) {
        if (index == 1) {
          context.push('/cart');
        }
      },
      selectedIndex: 0,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.star),
          label: AppLocalizations.of(context).shoppingPageTabShopping,
        ),
        NavigationDestination(
          icon: const Icon(Icons.shopping_cart),
          label: [
            AppLocalizations.of(context).shoppingPageTabCart,
            (cartQuantity > 0) ? '($cartQuantity)' : null,
          ].whereNotNull().join(' '),
        ),
      ],
    );
  }

  void _listener(BuildContext context, ShoppingPageState state) {
    switch (state.recommendedProductsStatus) {
      case ShoppingPageStatus.initial:
      case ShoppingPageStatus.loading:
      case ShoppingPageStatus.ready:
        break;

      case ShoppingPageStatus.failure:
        AppSnackBar.error(context, error: state.recommendedProductsError);
        break;
    }

    switch (state.productsStatus) {
      case ShoppingPageStatus.initial:
      case ShoppingPageStatus.loading:
      case ShoppingPageStatus.ready:
        break;

      case ShoppingPageStatus.failure:
        AppSnackBar.error(context, error: state.productsError);
        break;
    }
  }
}
