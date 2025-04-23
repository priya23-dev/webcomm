import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ Firebase Auth
import '../routes.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _createAccount() async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Account created successfully!')),
      );

      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section - Image & Form
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              child: Row(
                children: [
                  // Left Image
                  Expanded(
                    child: Image.asset(
                      "assets/images/signup_illustration.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Right Form Section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create an account",
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

                            // Name Input
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 10),

                            // Email Input
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email or Phone Number",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 10),

                            // Password Input
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20),

                            // Signup Button
                            ElevatedButton(
                              onPressed: _createAccount,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child: Text("Create Account", style: TextStyle(color: Colors.white)),
                            ),
                            SizedBox(height: 10),

                            // Google Signup Button
                            OutlinedButton.icon(
                              onPressed: () {
                                // Google sign-in can be added here if needed
                              },
                              icon: Image.asset(
                                "assets/images/google.png",
                                height: 24,
                              ),
                              label: Text("Sign up with Google"),
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                side: BorderSide(color: Colors.grey),
                              ),
                            ),

                            SizedBox(height: 10),
                            // Login Navigation
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/login");
                                  },
                                  child: Text(
                                    "Log in",
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
                  ),
                ],
              ),
            ),

            // Footer Section (unchanged)
            // You can keep your footerColumn widget and layout the same here as before...
          ],
        ),
      ),
    );
  }
}
