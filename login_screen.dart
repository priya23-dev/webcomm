import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase Login Function
  Future<void> _login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pushNamed(context, AppRoutes.home); // Redirect on success
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section - Image & Login Form
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              child: Row(
                children: [
                  // Left Image
                  Expanded(
                    child: Image.asset(
                      "assets/images/login_illustration.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Right Form Section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Log in to Exclusive",
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Enter your details below",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          SizedBox(height: 20),

                          // Email Input
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email or Phone Number",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),

                          // Password Input
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Login Button
                          ElevatedButton(
                            onPressed: () => _login(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Text("Log In", style: TextStyle(color: Colors.white)),
                          ),

                          SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to Forgot Password Page (optional)
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.signup);
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer Section
            Container(
              width: double.infinity,
              color: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Exclusive",
                      style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Subscribe and get 10% off your first order",
                      style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter your email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        child: Text("Subscribe"),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _footerColumn("Support", [
                        "111 Bijoy Sarani, Dhaka",
                        "exclusive@gmail.com",
                        "+88015-88888-9999",
                      ]),
                      _footerColumn("Account", [
                        "My Account",
                        "Login / Register",
                        "Cart",
                        "Wishlist",
                        "Shop",
                      ]),
                      _footerColumn("Quick Link", [
                        "Privacy Policy",
                        "Terms of Use",
                        "FAQ",
                        "Contact",
                      ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Download App", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset("assets/images/playstore.png", height: 40),
                              SizedBox(width: 10),
                              Image.asset("assets/images/appstore.png", height: 40),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              IconButton(icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white), onPressed: () {}),
                              IconButton(icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.white), onPressed: () {}),
                              IconButton(icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.white), onPressed: () {}),
                              IconButton(icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white), onPressed: () {}),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.white70),
                  Center(
                    child: Text(
                      "© Copyright RimeL 2022. All rights reserved",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(item, style: TextStyle(color: Colors.white70)),
          ),
      ],
    );
  }
}
