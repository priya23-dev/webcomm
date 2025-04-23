import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // ✅ Firebase Core
import 'routes.dart';
import 'providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase for Web with options
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC-6I_cXas5U-jwKeUxQxqMDABJo6emTFA",
      authDomain: "web1-e9c26.firebaseapp.com",
      projectId: "web1-e9c26",
      storageBucket: "web1-e9c26.appspot.com",
      messagingSenderId: "630391536685",
      appId: "1:630391536685:web:c90a8c6aee310216eecca4",
      measurementId: "G-JPJNKXP1ZH",
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
