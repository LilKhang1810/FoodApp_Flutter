// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_app/cart_view.dart';
import 'package:food_app/home_page.dart';

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.home_rounded,
              ),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.shopping_basket_sharp),
              text: 'Cart',
            )
          ],
        ),
        body: TabBarView(
          children: [
            HomePage(),
            CartView(),
          ],
        ),
      ),
    );
  }
}
