import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _submitLead() async {
    final url = Uri.parse("https://script.google.com/macros/s/AKfycbx1UIDqg-fXJakoFQRSZ7PWmJXpcHW5_61c-QQ9ZMPLD7CE_CGuecU2gX9RKvRB9rTV/exec"); // ✅ Replace with your script URL

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": _nameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "message": _messageController.text,
      }),
    );

    final result = jsonDecode(response.body);
    if (result["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lead submitted successfully!")));
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to submit lead")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: "Phone")),
            TextField(controller: _messageController, maxLines: 4, decoration: InputDecoration(labelText: "Message")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitLead,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
