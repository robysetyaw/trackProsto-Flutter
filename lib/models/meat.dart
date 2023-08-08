class Meat {
  final String name;
  final int stock;
  final int price;

  Meat({
    required this.name,
    required this.stock,
    required this.price,
  });

  factory Meat.fromJson(Map<String, dynamic> json) {
    return Meat(
      name: json['name'],
      stock: json['stock'],
      price: json['price'],
    );
  }
}
