import 'package:flutter/material.dart';
import 'package:food_app/model/food.dart';

class CartProvider extends ChangeNotifier {
  final List<Food> foods = [];
  void addToCart(Food food) {
    foods.add(food);
     notifyListeners(); 
  }

  void removeFromCart(Food food) {
    foods.remove(food);
     notifyListeners(); 
  }

  double getTotal() {
    return foods.fold(0, (sum, food) => sum + food.price);
  }
}
