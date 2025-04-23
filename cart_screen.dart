import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webcommerce/screens/checkout_screen.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: cartProvider.cartItems.isEmpty
          ? Center(child: Text("Your cart is empty!"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return ListTile(
                  leading: Image.asset(item["image"], width: 50),
                  title: Text(item["title"]),
                  subtitle: Text("Quantity: ${item["quantity"]}"),
                  trailing: Text(
                    "\$${(double.parse(item["price"]) * item["quantity"]).toStringAsFixed(2)}",
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen()),
                    ); // ✅ Corrected closing bracket position
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text("Proceed to Checkout", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
