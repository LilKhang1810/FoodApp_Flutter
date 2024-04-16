// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/detail_view.dart';
import 'package:food_app/model/brand.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_app/model/cart.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'model/food.dart';
import 'widget/recommend_list.dart';
import 'widget/card_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Brand> brandList = [];
  List<Food> foodList = [];
  late List<Food> filterFood = [];
  bool isSearching = false;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    getBrandData();
    getFoodData();
  }

  final imgBanners = [
    Image.asset('assets/img/Burgerking AD.jpeg'),
    Image.asset('assets/img/Chicken Finger Ads.jpeg'),
    Image.asset('assets/img/Domino AD.jpeg'),
    Image.asset('assets/img/KFC AD.jpeg'),
  ];

  int currentIndex = 0;
  void getBrandData() {
    FirebaseFirestore.instance
        .collection('Brand')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          brandList.add(
            Brand.fromMap(
              {
                'img_url': doc['img_url'],
                'name': doc['name'],
              },
            ),
          );
        });
      });
    });
  }

  void getFoodData() {
    FirebaseFirestore.instance
        .collection('Product ')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.data());

        setState(() {
          foodList.add(
            Food.fromMap(
              {
                'brand': doc['brand'],
                'img_url': doc['img_url'],
                'name': doc['name'],
                'price': doc['price'],
                'type': doc['type'],
                'popular': doc['popular'],
                'rating': doc['rating'],
              },
            ),
          );
        });
      });
    });
  }

  void filterResult(String key) {
    filterFood = foodList;
    setState(() {
      if (key.isNotEmpty) {
        isSearching = true;
        filterFood = foodList
            .where(
                (food) => food.name.toLowerCase().contains(key.toLowerCase()))
            .toList();
      } else {
        isSearching = false;
        filterFood = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          HomePageBar(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              onChanged: (key) => {filterResult(key)},
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 0.8),
                  ),
                  hintText: 'Gà rán, Pizza, ... ',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controller.clear();
                    },
                    icon: Icon(Icons.clear_sharp),
                  )),
            ),
          ),
          Stack(
            children: [
              Column(
                children: [
                  BrandsList(),
                  Banner(),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Title(title: 'Recommend for you'),
                      GestureDetector(
                        onTap: () {
                          print('Show All');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: <Widget>[
                              Text("Show all"),
                              Icon(Icons.arrow_forward_outlined)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  RecommendList(foodList: foodList),
                  Title(title: 'Category'),
                  SizedBox(
                    height: 20,
                  ),
                  CaterogyList(),
                  SizedBox(
                    height: 20,
                  ),
                  Title(title: 'Summer refreshment'),
                  Container(
                    height: 870,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.69,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: foodList
                            .where((food) => food.type == 'drinks')
                            .toList()
                            .length,
                        itemBuilder: (context, index) => CardProduct(
                            foodList: foodList
                                .where((food) => food.type == 'drinks')
                                .toList(),
                            index: index)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Visibility(
                    visible: isSearching && filterFood.isNotEmpty,
                    child: Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: filterFood.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailView(food: filterFood[index])));
                            },
                            title: Text(filterFood[index].name),
                            dense: true,
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  SizedBox CaterogyList() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          Caterogy(
            assetPath: 'assets/img/hamburger.png',
            title: 'Hamburger',
          ),
          SizedBox(
            width: 10,
          ),
          Caterogy(
            assetPath: 'assets/img/fried-chicken.png',
            title: 'Gà rán',
          ),
          SizedBox(
            width: 10,
          ),
          Caterogy(
            assetPath: 'assets/img/pizza.png',
            title: 'Pizza',
          ),
          SizedBox(
            width: 10,
          ),
          Caterogy(title: "Thức uống", assetPath: 'assets/img/lemonade.png')
        ],
      ),
    );
  }

  SingleChildScrollView Banner() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: imgBanners,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlay: true,
              height: 200,
            ),
          ),
          AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: imgBanners.length,
            effect: const WormEffect(
                dotHeight: 4,
                spacing: 10,
                dotColor: Colors.greenAccent,
                activeDotColor: Colors.green),
          ),
        ],
      ),
    );
  }

  SizedBox BrandsList() {
    return SizedBox(
      height: 80,
      child: GridView.builder(
          padding: EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Hiển thị 2 sản phẩm trên mỗi dòng
            // Khoảng cách giữa các sản phẩm theo chiều ngang
            mainAxisSpacing: 20.0, // Khoảng cách giữa các dòng theo chiều dọc
          ),
          scrollDirection: Axis.horizontal,
          itemCount: brandList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Image.network(
                brandList[index].img_url,
                fit: BoxFit.fitHeight,
              ),
            );
          }),
    );
  }
}

class Caterogy extends StatelessWidget {
  const Caterogy({
    super.key,
    required this.title,
    required this.assetPath,
  });
  final String title;
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('You hit me!');
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: 170,
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 30,
              child: Image.asset(assetPath),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageBar extends StatefulWidget {
  const HomePageBar({
    super.key,
  });

  @override
  State<HomePageBar> createState() => _HomePageBarState();
}

class _HomePageBarState extends State<HomePageBar> {
  CartProvider cart = CartProvider();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Title(title: 'Hello Khang!'),
        SizedBox(
          width: 160,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Consumer<CartProvider>(
            builder: (context, cart, _) => badges.Badge(
              position: badges.BadgePosition.topEnd(top: -4, end: 2),
              badgeContent: Text(
                cart.foods.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_bag_rounded,
                  color: Colors.yellow.shade700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontFamily: "SuperstarX"),
      ),
    );
  }
}
