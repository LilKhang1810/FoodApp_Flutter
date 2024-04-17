class Food {
  final String name;
  final String brand;
  final bool popular;
  final String img_url;
  final String type;
  final int price;
  final double rating;
  late bool isFavorited = false;
  Food({
    required this.name,
    required this.brand,
    required this.img_url,
    required this.type,
    required this.price,
    required this.popular,
    required this.rating,
  });
  factory Food.fromMap(Map<String, dynamic> data) {
    return Food(
      name: data['name'],
      brand: data['brand'],
      img_url: data['img_url'],
      type: data['type'],
      price: data['price'],
      popular: data['popular'],
      rating: data['rating'].toDouble(),
    );
  }
}
