import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/detail_view.dart';
import 'package:food_app/model/brand.dart';
import 'package:food_app/model/cart.dart';
import 'package:food_app/model/food.dart';
import 'package:food_app/tabview.dart';
import 'package:provider/provider.dart';
import 'favorite_view.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CartProvider(),
      ),
      ChangeNotifierProvider(create: (context) => FavoriteController()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TabView()
        // home: DetailView(
        //   food: Food(
        //       name: 'EVM serving of 6 chicken McNuggets™',
        //       brand: 'Mc Donald',
        //       img_url:
        //           'https://mcdonalds.vn/uploads/2018/food/evm/EVM_03_6pcs_chicken_mcnuggets_0.png',
        //       type: 'chicken fried',
        //       price: 79000,
        //       popular: true,
        //       rating: 4),
        // ),
        );
  }
}
