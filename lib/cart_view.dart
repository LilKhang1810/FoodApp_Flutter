import 'package:flutter/material.dart';
import 'package:food_app/model/food.dart';
import 'package:provider/provider.dart';

import 'model/cart.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartProvider cart = CartProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.foods.length,
            itemBuilder: ((context, index) {
              final food = cart.foods[index];
              return Dismissible(
                key: Key(food.name),
                background: Container(
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                ),
                onDismissed: (direction) {
                  cart.foods.removeAt(index);
                },
                direction: DismissDirection.endToStart,
                child: ListTile(
                  leading: Image.network(
                    food.img_url,
                    width: 100,
                  ),
                  title: Text(food.name),
                  subtitle: Text(food.price.toString()),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
