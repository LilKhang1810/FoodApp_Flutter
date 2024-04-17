import 'package:flutter/material.dart';

import '../model/food.dart';
import 'card_product.dart';

class RecommendList extends StatelessWidget {
  const RecommendList({
    super.key,
    required this.foodList,
  });

  final List<Food> foodList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 290,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: foodList.length,
          itemBuilder: (context, index) => CardProduct(
            foodList: foodList,
            index: index,
            isFavorite: foodList[index].isFavorited,
          ),
        ),
      ),
    );
  }
}
