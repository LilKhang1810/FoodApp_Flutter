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
  String formatCurrency(int price) {
    // Chuyển đổi giá tiền thành chuỗi và thêm dấu phẩy
    String formattedPrice = price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    // Trả về chuỗi định dạng giá tiền với đơn vị đ
    return '$formattedPrice đ';
  }

  CartProvider cart = CartProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<CartProvider>(builder: (context, cart, child) {
        if (cart.foods.isEmpty) {
          return Center(
            child: Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return Column(
            children: [
              Container(
                height: 450,
                child: ListView.builder(
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
                        subtitle: Text('${formatCurrency(food.price)}'),
                      ),
                    );
                  }),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text('${formatCurrency(cart.getTotal())}',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellow.shade300)),
                    onPressed: () {},
                    child: Text('Check Out')),
              )
            ],
          );
        }
      }),
    );
  }
}
