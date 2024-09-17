import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_14/components/bottomNavigationBar.dart';
import 'package:flutter_application_14/firebase_options.dart';
import 'package:flutter_application_14/pages/cartPage.dart';
import 'package:flutter_application_14/pages/ShopPage.dart';
import 'package:flutter_application_14/pages/wishList.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key,});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

final List<Widget> _pages = [
  const ShopPage(),  
  const CartPage(),
  const Wishlist(),
];


  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: bottomNavigationBar(onTabChange: _navigateBottomBar),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 100,
          title: Center(
            child: Image.asset("lib/images/download.png"),
          ),
          backgroundColor: const Color.fromARGB(255, 35, 47, 62),
        ),
        body: _pages[_selectedIndex], backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
