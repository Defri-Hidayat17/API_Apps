import 'package:flutter/material.dart';
import '../views/cart_page.dart';
import '../views/profile_page.dart';
import '../screens/product_list_screen.dart';
import '../widgets/gradient_icon.dart';

class BottomNavWrapper extends StatefulWidget {
  const BottomNavWrapper({super.key});

  @override
  State<BottomNavWrapper> createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  int _selectedIndex = 1; // Home default

  final List<Widget> _pages = const [
    CartPage(),
    ProductListScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: null, // kita pakai gradient icon manual
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        selectedLabelStyle: const TextStyle(fontFamily: 'InterSemiBold'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'InterMedium'),
        items: [
          BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.shopping_cart,
              isActive: _selectedIndex == 0,
            ),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: GradientIcon(icon: Icons.home, isActive: _selectedIndex == 1),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.person,
              isActive: _selectedIndex == 2,
            ),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
