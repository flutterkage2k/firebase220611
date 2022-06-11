// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, non_constant_identifier_names

import 'package:firebase06092121/main_screens/home.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Category'),
    BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Stores'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    HomeScreen(),
    Center(child: Text('Category Screen')),
    Center(child: Text('stores Screen')),
    Center(child: Text('cart Screen')),
    Center(child: Text('profile Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          selectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          items: btmNavItems,
          onTap: _onBtmItemClick),
    );
  }

  void _onBtmItemClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
