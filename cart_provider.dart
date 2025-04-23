import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  /// ✅ Add to Cart - Increases quantity if item exists
  void addToCart(Map<String, dynamic> product) {
    int index = _cartItems.indexWhere((item) => item["title"] == product["title"]);

    if (index != -1) {
      _cartItems[index]["quantity"] += product["quantity"]; // Update quantity if already in cart
    } else {
      _cartItems.add(product);
    }

    notifyListeners(); // Notify UI to rebuild
  }

  /// ✅ Remove Single Item from Cart
  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  /// ✅ Clear Entire Cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  /// ✅ Get Total Price of Cart Items
  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + (double.parse(item["price"]) * item["quantity"]));
  }

  /// ✅ Update Quantity of an Item
  void updateQuantity(int index, int newQuantity) {
    if (newQuantity > 0) {
      _cartItems[index]["quantity"] = newQuantity;
    } else {
      removeFromCart(index);
    }
    notifyListeners();
  }
}
