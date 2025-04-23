import 'package:flutter/material.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
//import 'screens/wishlist_screen.dart';
//import 'screens/profile_screen.dart';
//import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';

class AppRoutes {
  static const String signup = "/signup";
  static const String login = "/login";
  static const String home = "/home";
  static const String productDetail = "/product-detail";
  static const String cart = "/cart";
  static const String checkout = "/checkout";
  static const String wishlist = "/wishlist";
  static const String profile = "/profile";
  static const String about = "/about";
  static const String contact = "/contact";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case productDetail:
        if (settings.arguments is Map<String, dynamic>) {
          final product = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          );
        }
        else {
          return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: {
              "image": "assets/images/default.png",
              "title": "Product Not Found",
              "price": "0.00",
              "description": "No description available.",
            }),
          );
        }
      case about:
        return MaterialPageRoute(builder: (_) => ContactScreen());

      case cart:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case checkout:
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      default:
        return MaterialPageRoute(builder: (_) => SignupScreen());
    }
  }
}
