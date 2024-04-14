class Brand {
  final String name;
  final String img_url;

  Brand({
    required this.name,
    required this.img_url,
  });
  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      name: map['name'],
      img_url: map['img_url'],
    );
  }
}
