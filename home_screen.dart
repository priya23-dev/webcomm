import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webcommerce/screens/product_detail_screen.dart';
import '../routes.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/product1.png",
      "title": "Gaming Controller",
      "price": "29.99",
      "description": "Wireless gaming controller with precision control."
    },
    {
      "image": "assets/images/product2.png",
      "title": "Wireless Headphone",
      "price": "39.99",
      "description": "Noise-canceling wireless headphones with deep bass."
    },
    {
      "image": "assets/images/product3.png",
      "title": "Smart Chair",
      "price": "199.99",
      "description": "Ergonomic smart chair with adjustable lumbar support."
    },
    {
      "image": "assets/images/product4.png",
      "title": "RGB Mouse Pad",
      "price": "19.99",
      "description": "High-quality RGB gaming mouse pad with smooth surface."
    },
    {
      "image": "assets/images/product5.png",
      "title": "Stylish Handbag",
      "price": "49.99",
      "description": "Premium leather handbag with multiple compartments."
    },
    {
      "image": "assets/images/product6.png",
      "title": "Smartwatch Pro",
      "price": "199.99",
      "description": "Advanced smartwatch with heart rate & GPS tracking."
    },
    {
      "image": "assets/images/product7.png",
      "title": "Wireless Speaker",
      "price": "89.99",
      "description": "Portable Bluetooth speaker with high-quality sound."
    },
    {
      "image": "assets/images/product8.png",
      "title": "Professional Camera",
      "price": "499.99",
      "description": "DSLR camera with high-resolution lens and 4K video."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),

            // Banner Section
            _banner(),

            SizedBox(height: 30),

            // Flash Sales Section
            _sectionTitle("Flash Sales"),
            _productGrid(context, products.sublist(0, 4)),

            SizedBox(height: 30),

            // Browse by Category
            _sectionTitle("Browse By Category"),
            _categoryBrowse(),

            SizedBox(height: 30),

            // Best Selling Products
            _sectionTitle("Best Selling Products"),
            _productGrid(context, products),

            SizedBox(height: 30),

            // Promotional Banner
            _promoBanner(),

            SizedBox(height: 30),

            // Explore Our Products
            _sectionTitle("Explore Our Products"),
            _productGrid(context, products),

            SizedBox(height: 30),

            // New Arrivals
            _sectionTitle("New Arrivals"),
            _newArrivals(),

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

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
              _navItem(context, "Home", AppRoutes.home),
              _navItem(context, "Contact", AppRoutes.contact),
              _navItem(context, "About", AppRoutes.about),
              _navItem(context, "Sign Up", AppRoutes.signup),
              SizedBox(width: 20),
              _searchBar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _banner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 100),
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("assets/images/banner.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

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
                hintText: "What are you looking for?",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _productGrid(BuildContext context, List<Map<String, dynamic>> products) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return _productCard(context, products[index]);
        },
      ),
    );
  }

  Widget _productCard(BuildContext context, Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product["image"], height: 200),
            SizedBox(height: 10),
            Text(product["title"], style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
            Text("\$${product["price"]}", style: GoogleFonts.poppins(fontSize: 14, color: Colors.red)),
            Text(product["description"], maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }



  Widget _categoryBrowse() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _categoryCard("assets/images/laptop.png", "Laptops"),
          _categoryCard("assets/images/mobile.png", "Mobiles"),
          _categoryCard("assets/images/camera.png", "Cameras"),
          _categoryCard("assets/images/headphones.png", "Headphones"),
        ],
      ),
    );
  }

  Widget _categoryCard(String icon, String title) {
    return Column(
      children: [
        Image.asset(icon, height: 150),
        SizedBox(height: 10),
        Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _promoBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 100),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("assets/images/promo.png"),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _newArrivals() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100),
      child: Row(
        children: [
          Expanded(
            child: Image.asset("assets/images/newrarrival1.png", fit: BoxFit.cover),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Image.asset("assets/images/newarrival2.png", fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
