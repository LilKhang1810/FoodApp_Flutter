// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_app/cart_view.dart';
import 'package:food_app/home_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int _selectedIndex = 0;
  final List<Widget> tabOptions = <Widget>[
    HomePage(),
    CartView(),
    Center(child: Text('Favorite Screen')),
    Center(child: Text('Profile Screen')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabOptions[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.yellow.withOpacity(0.2),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 15),
          child: GNav(
            tabBorderRadius: 25,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            gap: 8,
            padding: EdgeInsets.all(6),
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: 'Trang chủ',
              ),
              GButton(
                icon: Icons.shopping_bag_rounded,
                text: 'Giỏ hàng',
              ),
              GButton(
                icon: Icons.favorite_sharp,
                text: 'Yêu thích',
              ),
              GButton(
                icon: Icons.person_rounded,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
