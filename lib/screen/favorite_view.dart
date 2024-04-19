import 'package:flutter/material.dart';
import 'package:food_app/model/food.dart';
import 'package:food_app/widget/card_product.dart';

import 'package:provider/provider.dart';

class FavoriteController extends ChangeNotifier {
  final List<Food> favList = [];
  bool isFavorite(Food food) {
    return favList.contains(food);
  }

  void addToFav(Food food) {
    favList.add(food);

    notifyListeners();
  }

  void removeFromFav(Food food) {
    favList.remove(food);

    notifyListeners();
  }
}

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String formatCurrency(int price) {
    // Chuyển đổi giá tiền thành chuỗi và thêm dấu phẩy
    String formattedPrice = price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    // Trả về chuỗi định dạng giá tiền với đơn vị đ
    return '$formattedPrice đ';
  }

  FavoriteController favController = FavoriteController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Món yêu thích',
          )),
      body: Consumer<FavoriteController>(
          builder: (context, favController, child) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.69,
            ),
            itemCount: favController.favList.length,
            itemBuilder: (context, index) => CardProduct(
                  foodList: favController.favList,
                  index: index,
                  isFavorite:
                      favController.isFavorite(favController.favList[index]),
                ));
      }),
    );
  }
}
