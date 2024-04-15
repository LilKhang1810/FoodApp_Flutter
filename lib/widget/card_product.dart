import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/detail_view.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';
import '../model/food.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    super.key,
    required this.foodList,
    required this.index,
  });

  final List<Food> foodList;
  final int index;
  String formatCurrency(int price) {
    // Chuyển đổi giá tiền thành chuỗi và thêm dấu phẩy
    String formattedPrice = price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    // Trả về chuỗi định dạng giá tiền với đơn vị đ
    return '$formattedPrice đ';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailView(food: foodList[index])));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 10),
        width: 170,
        height: 270,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(3),
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow,
                    ),
                    child: Text(
                      'G-Choice',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  )
                ],
              ),
              Container(
                child: Image.network(
                  foodList[index].img_url,
                  height: 120,
                ),
              ),
              Text(
                foodList[index].name,
                maxLines: 2, // Số dòng tối đa
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(children: <Widget>[
                Text(
                  '${formatCurrency(foodList[index].price)}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 70),
              ]),
              Row(
                children: [
                  Text(foodList[index].rating.toString()),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 75,
                  ),
                  GestureDetector(
                    onTap: () {
                      CartProvider cart =
                          Provider.of<CartProvider>(context, listen: false);
                      cart.addToCart(foodList[index]);
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.orangeAccent,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
