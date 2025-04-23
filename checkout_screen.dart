import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../routes.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    double totalAmount = cartProvider.totalPrice;

    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Summary",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartProvider.cartItems[index];
                  return ListTile(
                    leading: Image.asset(item["image"], width: 50),
                    title: Text(item["title"]),
                    subtitle: Text("Quantity: ${item["quantity"]}"),
                    trailing: Text("\$${double.parse(item["price"]) * item["quantity"]}"),
                  );
                },
              ),
            ),

            Divider(),
            SizedBox(height: 10),
            Text(
              "Total: \$${totalAmount.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context, totalAmount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text("Proceed to Checkout", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, double totalAmount) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Checkout"),
          content: Text("Your total amount is \$${totalAmount.toStringAsFixed(2)}. Do you want to proceed?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).clearCart(); // Clear Cart
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false); // Logout User
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
