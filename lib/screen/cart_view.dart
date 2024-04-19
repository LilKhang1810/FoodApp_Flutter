import 'package:flutter/material.dart';
import 'package:food_app/model/food.dart';
import 'package:food_app/screen/tabview.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';

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
        automaticallyImplyLeading: false,
        title: Text('Giỏ hàng'),
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
                      'Tổng cộng:',
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckOutScreen()));
                    },
                    child: Text('Thanh toán')),
              )
            ],
          );
        }
      }),
    );
  }
}

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  CartProvider provider = CartProvider();
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
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      'Thanh toán',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(child: Lottie.asset('assets/purchase.json')),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text('Tổng cộng')),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${formatCurrency(cart.getTotal())}',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Giao hàng tới'),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'A11/18 Quốc lộ 50 Bình Chánh',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  width: 300,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.yellow.shade300)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuccessfulScreen()));
                      },
                      child: Text(
                        'Xác nhận đơn hàng',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade300,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              child: Text(
                'Đã xác nhận thanh toán',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Lottie.asset('assets/success.json'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Bạn đợi xíu nhé, shipper sẽ giao món ăn tới ngay cho bạn ngay thôi <3',
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TabView()));
                    },
                    child: Text(
                      'Trở về trang chủ',
                      style: TextStyle(
                          color: Colors.yellow.shade300,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
