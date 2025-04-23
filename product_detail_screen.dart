import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webcommerce/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart'; // ✅ Import CartProvider
//import '../routes.dart'; // ✅ Import routes


class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context), // ✅ Header & Navigation

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Images
                  Column(
                    children: [
                      _productImage(widget.product["image"]),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          _thumbnailImage(widget.product["image"]),
                          _thumbnailImage(widget.product["image"]),
                          _thumbnailImage(widget.product["image"]),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 40),

                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product["title"] ?? "Product Not Found",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text("⭐ 4.5 (150 Reviews)"),
                            SizedBox(width: 10),
                            Text("| In Stock", style: TextStyle(color: Colors.green)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "\$${widget.product["price"] ?? "0.00"}",
                          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.product["description"] ?? "No description available.",
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        SizedBox(height: 20),

                        // Color Options
                        Row(
                          children: [
                            Text("Colours: "),
                            _colorCircle(Colors.black),
                            _colorCircle(Colors.blue),
                            _colorCircle(Colors.red),
                          ],
                        ),
                        SizedBox(height: 10),

                        // Size Options
                        Row(
                          children: [
                            Text("Size: "),
                            _sizeBox("XS"),
                            _sizeBox("S"),
                            _sizeBox("M", selected: true),
                            _sizeBox("L"),
                            _sizeBox("XL"),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Quantity Selector & Buy Now Button
                        Row(
                          children: [
                            _quantitySelector(),
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                // ✅ Add product to cart using Provider
                                Provider.of<CartProvider>(context, listen: false).addToCart({
                                  ...widget.product,
                                  "quantity": quantity
                                });

                                // ✅ Navigate to Cart Screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CartScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              ),
                              child: Text("Buy Now", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),


                        SizedBox(height: 20),
                        _infoBox("Free Delivery", "Enter postal code for delivery availability."),
                        _infoBox("Return Delivery", "Free 30 days delivery returns."),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ✅ Header & Navigation Bar
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Exclusive",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              _navItem(context, "Home"),
              _navItem(context, "Contact"),
              _navItem(context, "About"),
              _navItem(context, "Sign Up"),
              SizedBox(width: 20),
              _searchBar(),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ Navigation Item
  Widget _navItem(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          // Navigate to respective screens if needed
        },
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // ✅ Search Bar
  Widget _searchBar() {
    return Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Product Image
  Widget _productImage(String imagePath) {
    return Image.asset(
      imagePath,
      height: 200,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset("assets/images/default.png", height: 300);
      },
    );
  }

  // ✅ Thumbnail Image
  Widget _thumbnailImage(String image) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: _productImage(image),
    );
  }

  // ✅ Color Circle
  Widget _colorCircle(Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 12,
      ),
    );
  }

  // ✅ Size Box
  Widget _sizeBox(String size, {bool selected = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: selected ? Colors.red : Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(size),
      ),
    );
  }

  // ✅ Quantity Selector
  Widget _quantitySelector() {
    return Row(
      children: [
        IconButton(
          onPressed: decreaseQuantity,
          icon: Icon(Icons.remove),
        ),
        Text("$quantity", style: TextStyle(fontSize: 18)),
        IconButton(
          onPressed: increaseQuantity,
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  // ✅ Info Box
  Widget _infoBox(String title, String description) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Icon(Icons.local_shipping, color: Colors.grey),
          SizedBox(width: 10),
          Expanded(child: Text("$title - $description")),
        ],
      ),
    );
  }
}
