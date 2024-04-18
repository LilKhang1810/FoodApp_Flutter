import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/model/cart.dart';
import 'package:provider/provider.dart';
import '../model/food.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key, required this.food});
  final Food food;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  CartProvider cart = CartProvider();
  @override
  String formatCurrency(int price) {
    // Chuyển đổi giá tiền thành chuỗi và thêm dấu phẩy
    String formattedPrice = price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    // Trả về chuỗi định dạng giá tiền với đơn vị đ
    return '$formattedPrice đ';
  }

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('comments');
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: Image.network(
                  widget.food.img_url,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.food.name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      '1,4k Đã bán',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w200),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '400 Lượt thích',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w200),
                    ),
                    SizedBox(width: 135),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            '${widget.food.rating.toString()}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Colors.yellow.shade700,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow),
                      child: Text(
                        '${formatCurrency(widget.food.price)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        CartProvider cart =
                            Provider.of<CartProvider>(context, listen: false);
                        cart.addToCart(widget.food);
                        print('Added to cart:${widget.food.name}');
                      },
                      child: Icon(
                        Icons.shopping_basket,
                        color: Colors.orange,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Comments',
                  style: TextStyle(fontSize: 15, fontFamily: 'SuperstarX'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 750,
                  child: FirebaseAnimatedList(
                    physics: NeverScrollableScrollPhysics(),
                    query: ref,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map comment = snapshot.value as Map;
                      comment['key'] = snapshot.key;
                      return ListTile(
                        title: Text(comment['body']),
                        subtitle: Text('User: ${comment['user']['username']}'),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
