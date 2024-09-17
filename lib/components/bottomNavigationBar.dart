// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class bottomNavigationBar extends StatelessWidget {
  void Function(int)? onTabChange;
  bottomNavigationBar({super.key, required this.onTabChange});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GNav(
        color: Colors.black,
        activeColor: Colors.white,
        tabBackgroundColor: const Color.fromARGB(255, 35, 47, 62),
        gap: 12,
        backgroundColor: Colors.white,
        mainAxisAlignment: MainAxisAlignment.center,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "",
          ),
          GButton(icon: Icons.shopping_cart, text: ""),
          GButton(
            icon: Icons.stars,
            text: "",
          ),
        ],
      ),
    );
  }
}
