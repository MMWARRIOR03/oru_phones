class Product {
  final String name;
  final double price;
  final String make;
  final String storage;
  final String ram;

  Product(
      {required this.name,
      required this.price,
      required this.make,
      required this.storage,
      required this.ram});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      make: json['make'],
      storage: json['storage'],
      ram: json['ram'],
    );
  }
}
