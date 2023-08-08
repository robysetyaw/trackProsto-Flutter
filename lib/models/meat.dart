class Meat {
  final String name;
  final double stock;
  final double price;

  Meat({
    required this.name,
    required this.stock,
    required this.price,
  });

  factory Meat.fromJson(Map<String, dynamic> json) {
    return Meat(
      name: json['name'],
      stock: json['stock'].toDouble(),
      price: json['price'].toDouble(),
    );
  }
}
