import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_shopping/app/modules/cart/cart_page.dart';
import 'package:simple_shopping/app/modules/shopping/shopping_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: '/',
    routes: [
      /// '/'
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const ShoppingPage();
        },
        routes: [
          /// '/cart'
          GoRoute(
            path: 'cart',
            builder: (context, state) {
              return const CartPage();
            },
          ),
        ],
      ),
    ],
  );
}
